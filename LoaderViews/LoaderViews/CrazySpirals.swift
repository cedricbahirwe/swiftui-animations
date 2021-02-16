//
//  CrazySpirals.swift
//  LoaderViews
//
//  Created by Cédric Bahirwe on 15/02/2021.
//

import SwiftUI

struct CrazySpirals: View {
    @State var rotations = 1
    @State private var colors: [Color] = [.red, .green, .black, .blue]
    var body: some View {
        HStack {
            Spacer(minLength: 200)
            SpiroSquare(rotations: $rotations)
                .stroke()
                .fill(colors.randomElement()!)
                .frame(width: 200, height: 200)
                .onReceive(Timer.publish(every: 0.3, on: .main, in: .common).autoconnect(), perform: { _ in
                        rotations += 1
                })
        }
    }
}


struct SpiroSquare: Shape {
    @Binding var rotations: Int
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let amount = .pi / CGFloat(rotations)
        let transform = CGAffineTransform(rotationAngle: amount)
        
        for _ in 0 ..< rotations {
            path = path.applying(transform)
            path.addRect(CGRect(x: -rect.width / 2, y: -rect.height / 2, width: rect.width, height: rect.height))
        }
        return path
    }
}



struct CrazySpirals_Previews: PreviewProvider {
    static var previews: some View {
        CrazySpirals()
            .previewLayout(.fixed(width: 1000, height: 1000))
    }
}
