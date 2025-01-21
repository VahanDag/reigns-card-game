//
//  GameView.swift
//  reigns
//
//  Created by Vahan Dag on 20.01.2025.
//
import SwiftUI

struct GameView: View {
    @StateObject private var gameState = GameState()
    @State private var currentCard: Card? = nil
    @State private var showGameOver = false
    @State private var isCardVisible = true
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(spacing: 12) {
                    ForEach(ResourceType.allCases) { type in
                        ResourceBar(
                            type: type,
                            value: gameState.resources[type] ?? 50,
                            maxValue: GameState.maxResourceValue
                        )
                    }
                }
                .padding()
                
                Spacer()
                
                // Orta kısım: Aktif kart
                if let card = currentCard, isCardVisible {
                    CardView(card: card) { swipedRight in
                        handleCardChoice(swipedRight: swipedRight)
                    }
                    .transition(.scale)
                }
                
                Spacer()
                
                // Alt kısım: Yıl göstergesi
                Text("Yıl \(gameState.year)")
                    .font(.title)
                    .padding()
            }
        }
        .alert("Oyun Bitti!", isPresented: $showGameOver) {
            Button("Yeniden Başla", role: .cancel) {
                restartGame()
            }
        } message: {
            Text(gameState.gameOverReason ?? "")
        }
        .onChange(of: gameState.isGameOver) { newValue in
            showGameOver = newValue
        }
        .onAppear {
            loadNextCard()
        }
    }
    
    // MARK: - Game Logic
    private func handleCardChoice(swipedRight: Bool) {
        guard let card = currentCard else { return }
        
        let effects = swipedRight ? card.rightEffects : card.leftEffects
        
        withAnimation(.easeInOut) {
            gameState.updateResources(with: effects)
            isCardVisible = false
        }
        
        gameState.incrementYear()
        
        // Kartın kaybolma animasyonundan sonra yeni kartı yükle
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            currentCard = CardDatabase.getRandomCard()
            withAnimation(.spring()) {
                isCardVisible = true
            }
        }
    }
    
    private func loadNextCard() {
        withAnimation(.spring()) {
            currentCard = CardDatabase.getRandomCard()
            isCardVisible = true
        }
    }
    
    private func restartGame() {
        gameState.resources = ResourceType.allCases.reduce(into: [:]) { dict, type in
            dict[type] = 50
        }
        gameState.year = 1
        gameState.isGameOver = false
        gameState.gameOverReason = nil
        
        loadNextCard()
    }
}

#Preview {
    GameView()
}
