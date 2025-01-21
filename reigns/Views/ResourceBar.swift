//
//  ResourceBar.swift
//  reigns
//
//  Created by Vahan Dag on 20.01.2025.
//

import SwiftUI

struct ResourceBar: View {
    let type: ResourceType
    let value: Int
    let maxValue: Int
    
    private var color: Color {
        switch type {
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
    
    private var icon: String {
        switch type {
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
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 24))
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                    
                    Rectangle()
                        .fill(color)
                        .frame(width: calculateBarWidth(for: geometry.size.width))
                }
                .cornerRadius(5)
            }
            .frame(height: 10)
            
            Text("\(value)")
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(color)
        }
        .padding(.horizontal)
        .frame(height: 30)
    }
    
    private func calculateBarWidth(for totalWidth: CGFloat) -> CGFloat {
        let ratio = CGFloat(value) / CGFloat(maxValue)
        return totalWidth * ratio
    }
}

struct ResourceBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ResourceBar(type: .treasury, value: 75, maxValue: 100)
            ResourceBar(type: .people, value: 50, maxValue: 100)
            ResourceBar(type: .army, value: 25, maxValue: 100)
            ResourceBar(type: .church, value: 90, maxValue: 100)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
