//
//  OnboardingButton.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/1/23.
//

import Foundation
import SwiftUI

struct OnboardingButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        ZStack {
            Rectangle()
                .frame(height: 50)
                .cornerRadius(4)
                .font(Font.buttonText)
                .foregroundColor(Color("button-primary"))
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                .animation(.easeIn, value: 5)
            
            configuration.label
                .foregroundColor(Color("text-button"))
                
        }
        .padding(.horizontal)
        
    }
}

