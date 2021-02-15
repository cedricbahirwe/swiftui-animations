//
//  Loaders.swift
//  LoaderViews
//
//  Created by Cédric Bahirwe on 15/02/2021.
//

import SwiftUI

struct Loaders: View {
    var body: some View {
        LoaderView()
            .padding()
    }
}

struct Loaders_Previews: PreviewProvider {
    static var previews: some View {
        Loaders()
    }
}

struct LoaderView: View {
    
    @State private var isLoading = false
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .circular)
                        .frame(width: geometry.size.width / 1.1, height: 80)
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    HStack {
                        ZStack {
                            Circle()
                                .trim(from: 0, to: 0.7)
                                .stroke(Color.green, lineWidth: 5)
                                .frame(width: geometry.size.width / 10)
                                .rotationEffect(Angle(degrees: self.isLoading ? 360 : 0))
                                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                                .onAppear {
                                    self.isLoading = true
                                }
                        }
                        Text("Loading...")
                            .padding(.leading)
                            .font(.custom("Helvetica", size: 25))
                    }
                }
                .frame(width: geometry.size.width , height : geometry.size.height / 3)
                ZStack {
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color(.systemGray5), lineWidth: 5)
                        .frame(width: 250, height: 3)
                    
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.green, lineWidth: 5)
                        .frame(width: 30, height: 3)
                        .offset(x: self.isLoading ? 110 : -110, y: 0)
                        .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: true))
                }
                .frame(width: geometry.size.width , height : geometry.size.height / 3)
                
                LoadingBar()
                    .frame(width: geometry.size.width , height : geometry.size.height / 3)
            }
        }
    }
}


struct LoadingBar: View {
    let gradient : [Color] = [.red, .orange, .yellow, .orange, .green ]
    @State var loadingProgress: CGFloat = 0.0
    @State var startPoint = UnitPoint(x: -1, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 0)
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 300, height: 20)
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(gradient: Gradient(colors: gradient), startPoint: startPoint, endPoint: endPoint))
                .frame(width: 300 * loadingProgress, height: 20)
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false)) {
                self.startPoint = UnitPoint(x: 1, y: 0)
                self.endPoint = UnitPoint(x: 2, y: 0)
            }
            let _ = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
                if self.loadingProgress <= 1.0 {
                    withAnimation {
                        self.loadingProgress += 0.05
                    }
                }
            }
        }
    }
}
