//
//  petMinderApp.swift
//  petMinder
//
//  Created by Yamin Ayon on 8/15/23.
//

import SwiftUI

@main
struct petMinderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
