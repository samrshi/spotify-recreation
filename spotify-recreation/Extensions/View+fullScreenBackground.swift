//
//  View+fullScreenBackground.swift
//  spotify-recreation
//
//  Created by Samuel Shi on 2/24/22.
//

import SwiftUI

struct FullScreenBackground<BackgroundContent: View>: ViewModifier {
    let background: BackgroundContent
    
    func body(content: Content) -> some View {
        ZStack {
            background.ignoresSafeArea()
            
            content
        }
    }
}

extension View {
    func fullScreenBackground<BackgroundContent: View>(_ background: BackgroundContent) -> some View {
        self.modifier(FullScreenBackground(background: background))
    }
}
