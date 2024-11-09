//
//  RankerApp.swift
//  Ranker
//
//  Created by Will D on 11/9/24.
//

import SwiftUI

@main
struct RankerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ListModel())
        }
    }
}
