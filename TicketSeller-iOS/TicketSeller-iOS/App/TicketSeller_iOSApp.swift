//
//  TicketSeller_iOSApp.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 14/10/25.
//

import SwiftUI
import SwiftData

@main
struct TicketSeller_iOSApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MoviesView()
            .environmentObject(MainNavigation())
        }
        .modelContainer(sharedModelContainer)
    }
}
