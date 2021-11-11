//
//  MaterialEffect.swift
//  SwiftUI-Curved-Tab-Bar
//
//  Created by Golden Chimusinde on 8/11/2021.
//

import SwiftUI

struct MaterialEffect: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }

}

