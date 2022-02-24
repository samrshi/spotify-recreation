//
//  SpotifySlider.swift
//  spotify-recreation
//
//  Created by Samuel Shi on 2/18/22.
//

import SwiftUI

struct SpotifySliderView: UIViewRepresentable {
    @Binding var value: Double
    let maxValue: Double
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        slider.addAction(UIAction(handler: valueChanged), for: .valueChanged)
        slider.maximumValue = Float(maxValue)
        slider.tintColor = .white
        return slider
    }
    
    func updateUIView(_ slider: UISlider, context: Context) {
        slider.value = Float(value)
    }
    
    func valueChanged(action: UIAction) {
        let slider = action.sender as! UISlider
        self.value = Double(slider.value)
    }
}
