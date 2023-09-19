//
//  VerificationView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/31/23.
//

import SwiftUI
import Combine

struct VerificationView: View {
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Binding var currentStep: OnboardingStep
    @Binding var isOnboarding: Bool
    @FocusState private var focusedField: FocusedField?
    
    @State var verificationcode = ""
    
    @State var isButtonDisabled = false
    @State var isErrorVisible = false
    
    enum FocusedField {
        case d1, d2, d3, d4, d5, d6
    }
    
    @State private var text1 = ""
    @State private var text2 = ""
    @State private var text3 = ""
    @State private var text4 = ""
    @State private var text5 = ""
    @State private var text6 = ""
    
    @State private var allDigits = ""
    @State private var message = "Enter code"
    let masterCode = "123456"
    @State private var codeValid = false
    
    var body: some View {
        
        VStack {
            
            Text("Verification")
                .font(Font.mainTitle)
                .padding(.top, 52)
            
            Text("Enter the 6-digit verification code we sent to your device.")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            // Textfield
            ZStack {
                
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack {
                    TextField("", text: $verificationcode)
                        .foregroundColor(Color("text-input"))
                        .font(Font.bodyParagraph)
                        .keyboardType(.numberPad)
                        .onReceive(Just(verificationcode)) { _ in
                            TextHelper.limitText(&verificationcode, 6)
                        }
                    
                    Spacer()
                    
                    Button {
                        // Clear text field
                        verificationcode = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .frame(width: 19, height: 19)
                    .tint(Color("icons-input"))
    
                }
                .padding()
                
            }
            .padding(.top, 34)
            
            //Error label
            Text("Invalid verification code.")
                .foregroundColor(.red)
                .font(Font.bodyParagraph)
                .padding(.top, 20)
                .opacity(isErrorVisible ? 1 : 0)
            
            Spacer()
            
            Button {
                
                //Hide error message
                isErrorVisible = false
                
                //Disable button
                isButtonDisabled = true
                
                // Send the verification code to Firebase
                AuthViewModel.verifyCode(code: verificationcode) { error in
                    
                    // Check for errors
                    if error == nil {
                        
                        // Check if this user has a profile
                        DatabaseService().checkUserProfile { exists in
                            
                            if exists {
                                // End the onboarding
                                isOnboarding = false
                                
                                //Load local contact info
                                contactsViewModel.getLocalContacts()
                                
                                //Loads existing chats
                                chatViewModel.getChats()
                                
                            }
                            else {
                                // Move to the profile creation step
                                currentStep = .profile
                            }
                        }
                    }
                    else {
                        //Show error message
                        isErrorVisible = true
                    }
                    
                    //Renew button function
                    isButtonDisabled = false
                }

            } label: {
                
                HStack {
                    Text("Next")
                    
                    if isButtonDisabled {
                        ProgressView()
                            .padding(.leading, 2)
                    }
                }
            }
            .buttonStyle(OnboardingButton())
            .padding(.bottom, 87)
            .disabled(isButtonDisabled)

            
        }
        .padding(.horizontal)
        
    }

    }
    
    struct VerificationView_Previews: PreviewProvider {
        static var previews: some View {
            VerificationView(currentStep: .constant(.verification), isOnboarding: .constant(true))
        }
    }

