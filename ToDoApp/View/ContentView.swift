//
//  ContentView.swift
//  ToDoApp
//
//  Created by Rafael Carvalho on 31/03/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var todos: FetchedResults<ToDo>

    @State private var showingAddToDoView: Bool = false
    @State private var animatedButton: Bool = false
    @State private var showingSettingsView: Bool = false

    // MARK: - Functions

    private func deleteToDo(offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)

            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(self.todos, id: \.self) { todo in
                        HStack {
                            Text(todo.name ?? "Unkown")

                            Spacer()

                            Text(todo.priority ?? "Unkown")
                        }
                    }
                    .onDelete(perform: deleteToDo)
                } //: List
                .navigationBarTitle("To Do", displayMode: .inline)
                .navigationBarItems(
                    leading: EditButton(),
                    trailing:
                        Button(action: {
                            self.showingSettingsView.toggle()
                        }) {
                            Image(systemName: "paintbrush")
                        } //: Add button
                        .sheet(isPresented: $showingSettingsView, content: {
                            SettingsView()
                        })
                )
                
                // MARK: - No To Do Itens
                if todos.count == 0 {
                    EmptyListView()
                }
            }//:ZStack
            .sheet(isPresented: $showingAddToDoView, content: {
                AddToDoView().environment(\.managedObjectContext, self.managedObjectContext)
            })
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(.blue)
                            .opacity(self.animatedButton ? 0.2 : 0)
                            .scaleEffect(self.animatedButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(.blue)
                            .opacity(self.animatedButton ? 0.15 : 0)
                            .scaleEffect(self.animatedButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true))
                    
                    Button(action: {
                        self.showingAddToDoView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    })
                    .onAppear(perform: {
                        self.animatedButton.toggle()
                    })
                }//:ZStack
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                , alignment: .bottomTrailing
            )
        } //: NavigationView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
