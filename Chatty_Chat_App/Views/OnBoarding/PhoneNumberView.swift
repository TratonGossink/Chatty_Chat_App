//
//  PhoneNumberView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/31/23.
//

import SwiftUI

struct PhoneNumberView: View {
    
    @Binding var currentStep: OnboardingStep
    
    @State var phoneNumber = ""
    
    var body: some View {
       
        VStack {
            
            Text("Verification")
                .font(Font.mainTitle)
                .padding(.top, 52)
            Text("Enter a vaid phone number below, We'll send a verification code to verify.")
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
                   
                    TextField("e.g. +1 123 123 1234", text: $phoneNumber )
                        .foregroundColor(Color("text-input"))
                        .font(Font.bodyParagraph)
                        .padding(.leading, 32)
                    Spacer()
                    
                    
                    Button {
                        phoneNumber = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .frame(width: 19, height: 19)
                    .foregroundColor(Color("text-input"))
                    .padding(.trailing, 24)
                }
                .padding()
            }
            .padding(.top, 34)
            
            Spacer()
            
            Button {
                currentStep = .verification
                
            } label: {
                Text("Next")
                
                   
            }
            .buttonStyle(OnboardingButton())
        }
        .padding(.bottom, 64)
        
    }
}

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView(currentStep: .constant(.phonenumber))
    }
}
