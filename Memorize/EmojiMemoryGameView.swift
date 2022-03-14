//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Santos Enoque on 10/03/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNamespace
 
    var body: some View {
        ZStack (alignment: .bottom){
            VStack{
                gameBody
               
                
                HStack {
                    restartButton
                    Spacer()
                    shuffleButton
                }
            }
            deckBody
        }.padding()
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: {$0.id == card.id}){
            delay = Double(index) * (CardConstants.totalDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(for card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3 ) { card in
            if isUndealt(card) || ( card.isMatched && !card.isFacedUp ) {
                Color.clear
            } else {
                CardView(card: card)
                    .zIndex(zIndex(for: card))
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
                    .onTapGesture {
                    withAnimation() {
                        game.choose(card)
                    }
                }
            }
        }
    
        .foregroundColor(.red)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) {
                CardView(card: $0)
                    .zIndex(zIndex(for: $0))
                    .matchedGeometryEffect(id: $0.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
            }
        }
        .frame(width: CardConstants.undealtWidth,height:CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            // deal the card
            for card in game.cards {
            withAnimation (dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
        
    }
    
    var shuffleButton: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
    }
    
    var restartButton: some View {
        Button("Restart") {
            withAnimation {
                dealt = []
                game.restart()
            }
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let undealtHeight: CGFloat = 90
        static let undealtWidth: CGFloat = undealtHeight * aspectRatio
        static let totalDuration: Double = 2
    }
 
    
}
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0 - 90), endAngle:Angle(degrees: 110 - 90))
                    .padding(6)
                    .opacity(0.4)
                Text(card.content)
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }.cardify(isFacedUp: card.isFacedUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private func getFont(in size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
        
    }
}
