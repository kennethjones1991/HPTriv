//
//  TrivApp.swift
//  Triv
//
//  Created by Kenneth Jones on 8/26/22.
//

import SwiftUI

@main
struct TrivApp: App {
    private let game = Game()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(game)
        }
    }
}
