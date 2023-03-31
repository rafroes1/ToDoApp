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
                        self.showingAddToDoView.toggle()
                    }) {
                        Image(systemName: "plus")
                    } //: Add button
                    .sheet(isPresented: $showingAddToDoView, content: {
                        AddToDoView().environment(\.managedObjectContext, self.managedObjectContext)
                    })
            )
        } //: NavigationView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
