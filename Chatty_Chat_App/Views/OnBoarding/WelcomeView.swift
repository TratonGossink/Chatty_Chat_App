//
//  WelcomeView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/31/23.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var currentStep: OnboardingStep
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Image("onboarding-welcome")
            Text("Welcome to Chatty Chat App")
                .font(Font.mainHeading)
                .padding(.top, 32)
            Text("Stress free chatting designed for you")
                .font(Font.bodyParagraph)
                .padding(.top, 8)
            
            
            Spacer()
            Button {
                currentStep = .phonenumber
            } label: {
                    Text("Get Started")
                }
            .buttonStyle(OnboardingButton())
            
Text("By tappig on 'Get Started', you agree to our Privacy Policy")
                .underline()
                .font(Font.caption)
                .padding(.top, 14)
                .padding(.bottom, 24)
        }
        
    }
    
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(currentStep: .constant(.welcome))
    }
}
