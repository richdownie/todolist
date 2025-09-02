//
//  ContentView.swift
//  todolist
//
//  Created by Rich Downie on 9/1/25.
//

import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
    let createdAt: Date = Date()
}

struct ContentView: View {
    @State private var todos: [TodoItem] = []
    @State private var newTodoText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add new todo...", text: $newTodoText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: addTodo) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                    .disabled(newTodoText.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding()
                
                List(todos) { todo in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(todo.title)
                            Text(todo.createdAt, format: .dateTime.hour().minute())
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button(action: {
                            deleteTodo(todo)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Todo List")
        }
    }
    
    private func addTodo() {
        let trimmedText = newTodoText.trimmingCharacters(in: .whitespaces)
        guard !trimmedText.isEmpty else { return }
        
        todos.append(TodoItem(title: trimmedText))
        newTodoText = ""
    }
    
    private func deleteTodo(_ todo: TodoItem) {
        todos.removeAll { $0.id == todo.id }
    }
}

#Preview {
    ContentView()
}
