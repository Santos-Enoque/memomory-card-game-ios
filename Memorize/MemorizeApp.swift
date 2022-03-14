//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Santos Enoque on 10/03/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
