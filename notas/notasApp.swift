//
//  notasApp.swift
//  notas
//
//  Created by Igmer Rodriguez on 10/1/23.
//

import SwiftUI

@main
struct notasApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
