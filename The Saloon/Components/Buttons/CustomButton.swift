//
//  CustomButton.swift
//  The Saloon
//
//  Created by SEAN BLAKE on 7/9/22.
//

import SwiftUI

struct CustomButton: View {
    
    @State private var angle = 0.0
    var gradient1: [Color] = [
        Color.init(red: 101/255, green: 134/255, blue: 1),
        Color.init(red: 1, green: 64/255, blue: 80/255),
        Color.init(red: 109/255, green: 1, blue: 185/255),
        Color.init(red: 39/255, green: 232/255, blue: 1)
    ]
    var buttonTitle: String
    var buttonAction: () -> Void
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            GeometryReader() { geometry in
                ZStack {
                    AngularGradient(gradient: Gradient(colors: gradient1), center: .center, angle: .degrees(angle))
                        .blendMode(.overlay)
                        .blur(radius: 8.0)
                        .mask(
                            RoundedRectangle(cornerRadius: 24.0)
                                .frame(height: 50)
                                .frame(maxWidth: geometry.size.width - 16)
                                .blur(radius: 8.0)
                        )
                        .onAppear() {
                            withAnimation(.linear(duration: 7)) {
                                self.angle += 350
                            }
                        }
                    Text(buttonTitle)
                        .font(.headline)
                        .foregroundColor(Color("ThemePrimary"))
                        .frame(width: geometry.size.width - 16)
                        .frame(height: 50)
                        .background(
                            Color("ThemeSecondary").opacity(0.9)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20.0)
                                .stroke(Color.white, lineWidth: 1.0)
                                .blendMode(.normal)
                                .opacity(0.7)
                        )
                        .cornerRadius(24.0)
                }
            }
            .frame(height: 50.0)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(buttonTitle: "Login", buttonAction: {})
    }
}
