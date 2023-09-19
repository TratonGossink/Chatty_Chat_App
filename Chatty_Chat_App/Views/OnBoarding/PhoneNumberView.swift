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
    
    @State var isButtonDisabled = false
    
    @State var isErrorVisible = false
    
    var body: some View {
       
        VStack {
            
            Text("Verification")
                .font(Font.mainTitle)
                .padding(.top, 52)
            Text("Enter a vaid phone number below, We'll send a verification code to verify.")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            //Textfield
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
                        .foregroundColor(Color("text-input"))
                        .font(Font.bodyParagraph)
                        .padding(.leading, 32)
                        .keyboardType(.numberPad)
                        .onReceive(Just(phoneNumber)) { _ in
                            TextHelper.applyPatternOnNumbers(&phoneNumber, pattern: "+# (###) ###-####", replacementCharacter: "#")
                        }
                        .placeholder(when: phoneNumber.isEmpty) {
                            Text("e.g. +1 613 515 0123")
                                .foregroundColor(Color("text-searchfield"))
                                .font(Font.bodyParagraph)
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
            
            //Error label
            Text("Please enter a valid phone number.")
                .foregroundColor(.red)
                .font(Font.bodyParagraph)
                .padding(.top, 20)
                .opacity(isErrorVisible ? 1 : 0)
            
            Spacer()
            
            Button {
                    
                //Hide error message
                isErrorVisible = false
                
                //Disable button from multiple taps
                isButtonDisabled = true
                
                AuthViewModel.sendPhoneNumber(phone: phoneNumber) { error in
                    
                    if error == nil {
                        currentStep = .verification
                    }
                    else {
                        
                        //show error
                        
                        isErrorVisible = true
                    }
                    
                    //Renable disable button
                    isButtonDisabled = false
                }
                
                
            } label: {
                ZStack {
                    Text("Next")
                    
                    if isButtonDisabled {
                        
                        ProgressView()
                        Text("")
                    
                    }
                }
                
                   
            }
            .buttonStyle(OnboardingButton())
            .disabled(isButtonDisabled)
        }
        .padding(.bottom, 64)
        
    }
}

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView(currentStep: .constant(.phonenumber))
    }
}
