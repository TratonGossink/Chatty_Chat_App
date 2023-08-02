//
//  VerificationView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/31/23.
//

import SwiftUI

struct VerificationView: View {
    
    @Binding var currentStep: OnboardingStep
    
    @State var verificationCode = ""
    
    var body: some View {
       
        VStack {
            
            Text("Verification")
                .font(Font.mainTitle)
                .padding(.top, 52)
            Text("Enter the 6-digit verification code we sent to your device..")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            ZStack {
                Rectangle()
                    .frame(height: 56)
                    .cornerRadius(5)
                    .font(Font.subheadline)
                    .padding(.horizontal)
                    .foregroundColor(Color("input"))
                  
                
                Spacer()
                HStack {
                   
                    TextField("", text: $verificationCode )
                        .foregroundColor(Color("text-input"))
                        .font(Font.bodyParagraph)
                        .padding(.leading, 32)
                    Spacer()
                    
                }
                .padding()
            }
            .padding(.top, 34)
            
            Spacer()
            
            Button {
                currentStep = .profile
                
            } label: {
                Text("Next")
                
                   
            }
            .buttonStyle(OnboardingButton())
        }
        .padding(.bottom, 64)
        
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(currentStep: .constant(.profile))
    }
}
