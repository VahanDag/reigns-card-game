//
//  CardView.swift
//  reigns
//
//  Created by Vahan Dag on 20.01.2025.
//

import SwiftUI


struct CardView: View {
    let card: Card
    let onCardSwiped: (Bool) -> Void  // true = sağa, false = sola
    
    @State private var offset: CGSize = .zero
    @State private var isBeingDragged = false
    
    private var rotationAngle: Double {
        Double(offset.width / 20)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 5)
            
            VStack(spacing: 20) {
                Text(card.character)
                    .font(.title)
                    .bold()
                
                Text(card.text)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                HStack {
                    Text(card.leftChoice)
                        .opacity(offset.width < 0 ? 1 : 0)
                    Spacer()
                    Text(card.rightChoice)
                        .opacity(offset.width > 0 ? 1 : 0)
                }
                .padding()
            }
        }
        .frame(width: 300, height: 400)
        .offset(offset)
        .rotationEffect(.degrees(rotationAngle))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    isBeingDragged = true
                }
                .onEnded { gesture in
                    let dragThreshold: CGFloat = 100
                    
                    if abs(gesture.translation.width) > dragThreshold {
                        let swipedRight = gesture.translation.width > 0
                        
                        withAnimation(.spring()) {
                            offset.width = swipedRight ? 1000 : -1000
                        }
                        
                        onCardSwiped(swipedRight)
                    } else {
                        withAnimation(.spring()) {
                            offset = .zero
                            isBeingDragged = false
                        }
                    }
                }
        )
    }
}

struct CardView_Preview: PreviewProvider {
    static var previews: some View {
        CardView(
            card: Card(
                id: UUID(),
                character: "Başdanışman",
                text: "Majesteleri, komşu krallık ile bir ticaret anlaşması yapmak istiyor.",
                leftChoice: "Reddet",
                leftEffects: [
                    ResourceEffect(resource: .treasury, amount: -10),
                    ResourceEffect(resource: .people, amount: 5)
                ],
                rightChoice: "Kabul Et",
                rightEffects: [
                    ResourceEffect(resource: .treasury, amount: 15),
                    ResourceEffect(resource: .people, amount: -5)
                ]
            ),
            onCardSwiped: { _ in }
        )
    }
}
