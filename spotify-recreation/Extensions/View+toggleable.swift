//
//  View+toggleable.swift
//  spotify-recreation
//
//  Created by Samuel Shi on 2/18/22.
//

import SwiftUI

struct Toggleable: ViewModifier {
    @Binding var isOn: Bool
    
    let onColor: Color
    let offColor: Color

    func body(content: Content) -> some View {
        Button(action: {
            isOn.toggle()
        }, label: {
            VStack(spacing: 0) {
                content

                if isOn {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 4, height: 4)
                }
            }
        })
        .offset(x: 0, y: isOn ? 2 : 0)
        .foregroundColor(isOn ? onColor : offColor)
    }
}

extension View {
    func toggleable(isOn: Binding<Bool>, onColor: Color, offColor: Color) -> some View {
        modifier(Toggleable(isOn: isOn, onColor: onColor, offColor: offColor))
    }
}
