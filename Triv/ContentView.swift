//
//  ContentView.swift
//  Triv
//
//  Created by Kenneth Jones on 8/26/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var game: Game
//    @State var playGame = false
    
    var body: some View {
        switch game.gameStatus {
        case .notPlaying:
            TitleView()
                .environmentObject(game)
        case .playing:
            Gameplay()
                .environmentObject(game)
        }
//        return Group {
//            if playGame {
//                Gameplay(playGame: $playGame)
//                    .environmentObject(game)
//            } else {
//                TitleView(playGame: $playGame)
//                    .environmentObject(game)
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Game())
    }
}
