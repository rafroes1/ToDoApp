//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Rafael Carvalho on 31/03/23.
//

import SwiftUI

@main
struct ToDoAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
