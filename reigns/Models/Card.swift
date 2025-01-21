//
//  Card.swift
//  reigns
//
//  Created by Vahan Dag on 20.01.2025.
//

import Foundation
import SwiftUI

// Resource türlerini tanımlayan enum
enum ResourceType: String, CaseIterable, Identifiable {
    case treasury
    case people
    case army
    case church
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .treasury:
            return "Hazine"
        case .people:
            return "Halk"
        case .army:
            return "Ordu"
        case .church:
            return "Kilise"
        }
    }
    
    var color: Color {
        switch self {
        case .treasury:
            return .yellow
        case .people:
            return .blue
        case .army:
            return .red
        case .church:
            return .purple
        }
    }
    
    var icon: String {
        switch self {
        case .treasury:
            return "dollarsign.circle.fill"
        case .people:
            return "person.3.fill"
        case .army:
            return "shield.fill"
        case .church:
            return "cross.fill"
        }
    }
}

// Kaynak etkisini tanımlayan struct
struct ResourceEffect {
    let resource: ResourceType
    let amount: Int
}

struct Card {
    let id: UUID
    let character: String
    let text: String
    
    // Sol kaydırma seçeneği
    let leftChoice: String
    let leftEffects: [ResourceEffect]
    
    // Sağ kaydırma seçeneği
    let rightChoice: String
    let rightEffects: [ResourceEffect]
}
