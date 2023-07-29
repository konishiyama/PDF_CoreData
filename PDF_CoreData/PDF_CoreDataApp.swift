//
//  PDF_CoreDataApp.swift
//  PDF_CoreData
//
//  Created by KO NISHIYAMA on 2023/07/29.
//

import SwiftUI

@main
struct PDF_CoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
