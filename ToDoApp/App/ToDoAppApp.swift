//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Rafael Carvalho on 31/03/23.
//

import SwiftUI

@main
struct ToDoAppApp: App {
    @StateObject private var persistenceController = PersistenceController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
