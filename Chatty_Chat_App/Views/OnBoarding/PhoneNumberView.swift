//
//  PhoneNumberView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/31/23.
//

import SwiftUI
import Combine

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
                   
                    TextField("e.g. +1 613 515 0123", text: $phoneNumber )
                        .foregroundColor(Color(.black))
                        .font(Font.bodyParagraph)
                        .padding(.leading, 32)
                        .keyboardType(.numberPad)
                        .onReceive(Just(phoneNumber)) { _ in
                            TextHelper.applyPatternOnNumbers(&phoneNumber, pattern: "+# (###) ###-####", replacementCharacter: "#")
                        }
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
//                TODO: Sends phone number to database - i.e. Firebase Auth
//                currentStep = .verification
                
                AuthViewModel.sendPhoneNumber(phone: phoneNumber) { error in
                    
                    if error == nil {
                        currentStep = .verification
                    }
                    else {
                        //TODO: show error
                    }
                }
                
                
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
