//
//  Cards.swift
//  reigns
//
//  Created by Vahan Dag on 20.01.2025.
//

import Foundation

// Oyundaki tüm kartları tutan static bir sınıf
struct CardDatabase {
    static let cards: [Card] = [
        Card(
            id: UUID(),
            character: "Başdanışman",
            text: "Majesteleri, komşu krallık ile bir ticaret anlaşması yapmak istiyor.",
            leftChoice: "Reddet",
            leftEffects: [
                ResourceEffect(resource: .treasury, amount: -10),
                ResourceEffect(resource: .people, amount: 5)
            ],
            rightChoice: "Kabul et",
            rightEffects: [
                ResourceEffect(resource: .treasury, amount: 15),
                ResourceEffect(resource: .people, amount: -5)
            ]
        ),
        Card(
            id: UUID(),
            character: "General",
            text: "Ordumuz yeni silahlar ve zırhlar istiyor. Bu yatırım güvenliğimiz için önemli.",
            leftChoice: "Yatırım yapma",
            leftEffects: [
                ResourceEffect(resource: .treasury, amount: 10),
                ResourceEffect(resource: .army, amount: -15)
            ],
            rightChoice: "Yatırım yap",
            rightEffects: [
                ResourceEffect(resource: .treasury, amount: -20),
                ResourceEffect(resource: .army, amount: 20)
            ]
        ),
        Card(
            id: UUID(),
            character: "Başrahip",
            text: "Kilisenin onarıma ihtiyacı var. Tanrı'nın evi bakımsız kalmamalı.",
            leftChoice: "Görmezden gel",
            leftEffects: [
                ResourceEffect(resource: .treasury, amount: 5),
                ResourceEffect(resource: .church, amount: -15)
            ],
            rightChoice: "Onarım emri ver",
            rightEffects: [
                ResourceEffect(resource: .treasury, amount: -15),
                ResourceEffect(resource: .church, amount: 20)
            ]
        ),
        Card(
            id: UUID(),
            character: "Halk Temsilcisi",
            text: "Halk açlıktan kırılıyor! Vergileri düşürmeliyiz.",
            leftChoice: "Talepleri reddet",
            leftEffects: [
                ResourceEffect(resource: .treasury, amount: 15),
                ResourceEffect(resource: .people, amount: -20)
            ],
            rightChoice: "Vergileri düşür",
            rightEffects: [
                ResourceEffect(resource: .treasury, amount: -15),
                ResourceEffect(resource: .people, amount: 25)
            ]
        )
    ]
    
    // Rastgele kart seçme fonksiyonu
    static func getRandomCard() -> Card {
        cards.randomElement() ?? cards[0]
    }
}
