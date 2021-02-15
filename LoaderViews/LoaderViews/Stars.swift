//
//  Stars.swift
//  LoaderViews
//
//  Created by Cédric Bahirwe on 15/02/2021.
//

import SwiftUI

struct Stars: View {
    
    @State var corners = 5
    @State var smoothness: CGFloat  =  0.1 // 0.45
    
    var body: some View {
        Star(corners: corners, smoothness: smoothness)
            .fill(Color.red)
            .frame(width: 300, height: 300)
//                .background(Color.green)
            .rotationEffect(.degrees(Double(corners*80)))
            .onReceive(Timer.publish(every: 0.2, on: .main, in: .common).autoconnect(), perform: { _ in
                withAnimation {
                    corners += 1
                    smoothness += 0.02
                }
            })    }
}

struct Stars_Previews: PreviewProvider {
    static var previews: some View {
        Stars()
    }
}


struct Star: Shape {
    
    let corners: Int
    let smoothness: CGFloat
    
    func path(in rect: CGRect) -> Path {
        guard corners >= 2 else { return Path() }
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        
        var currentAngle = -CGFloat.pi / 2
        
        let angleAdjustement = .pi * 2 / CGFloat(corners * 2)
        
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness
        
        var path = Path()
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))
        
        var bottomEdge: CGFloat = 0
        
        
        for corner in 0 ..< corners * 2 {
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            
            let bottom: CGFloat
            
            
            if corner.isMultiple(of: 2) {
                bottom = center.y * sinAngle
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                bottom = innerY * sinAngle
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }
            
            
            if bottom > bottomEdge {
                bottomEdge = bottom
            }
            currentAngle += angleAdjustement
        }
        
        let unusedSpace = (rect.height / 2 - bottomEdge) / 2
        
        let tranform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        
        return path.applying(tranform)
    }
}
