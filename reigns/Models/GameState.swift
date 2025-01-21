//
//  GameState.swift
//  reigns
//
//  Created by Vahan Dag on 20.01.2025.
//

import Foundation

class GameState: ObservableObject {
    @Published var resources: [ResourceType: Int]
    @Published var year: Int
    @Published var isGameOver: Bool
    @Published var gameOverReason: String?
    
    static let maxResourceValue = 100
    static let minResourceValue = 0
    
    init() {
        self.resources = [
            .treasury: 50,
            .people: 50,
            .army: 50,
            .church: 50
        ]
        self.year = 1
        self.isGameOver = false
        self.gameOverReason = nil
    }
    
    func updateResources(with effects: [ResourceEffect]) {
        for effect in effects {
            if var currentValue = resources[effect.resource] {
                currentValue += effect.amount
                
                currentValue = min(max(currentValue, GameState.minResourceValue), GameState.maxResourceValue)
                
                resources[effect.resource] = currentValue
                
                checkGameOver(resource: effect.resource, value: currentValue)
            }
        }
    }
    
    func incrementYear() {
        year += 1
    }
    
    private func checkGameOver(resource: ResourceType, value: Int) {
        if value <= GameState.minResourceValue {
            isGameOver = true
            gameOverReason = "\(resource.displayName) tükendi!"
        } else if value >= GameState.maxResourceValue {
            isGameOver = true
            gameOverReason = "\(resource.displayName) kontrolden çıktı!"
        }
    }
}
