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
            
            Spacer()
            
            Button {
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
                        // TODO: Show error message
                    }
                }

            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButton())
            .padding(.bottom, 87)

            
        }
        .padding(.horizontal)
        
    }

    }
    
    struct VerificationView_Previews: PreviewProvider {
        static var previews: some View {
            VerificationView(currentStep: .constant(.verification), isOnboarding: .constant(true))
        }
    }
    

//    var body: some View {
//        VStack(spacing: 64) {
//            HStack {
//                Spacer()
//                TextField("", text: $text1)
//                    .textFieldStyle(DigitTextFieldStyle())
//                    .keyboardType(.numberPad)
//                    .focused($focusedField, equals: .d1)
//                    .opacity(codeValid ? 0 : 1)
//
//                TextField("", text: $text2)
//                    .textFieldStyle(DigitTextFieldStyle())
//                    .keyboardType(.numberPad)
//                    .focused($focusedField, equals: .d2)
//                    .opacity(codeValid ? 0 : 1)
//
//                TextField("", text: $text3)
//                    .textFieldStyle(DigitTextFieldStyle())
//                    .keyboardType(.numberPad)
//                    .focused($focusedField, equals: .d3)
//                    .opacity(codeValid ? 0 : 1)
//
//                TextField("", text: $text4)
//                    .textFieldStyle(DigitTextFieldStyle())
//                    .keyboardType(.numberPad)
//                    .focused($focusedField, equals: .d4)
//                    .opacity(codeValid ? 0 : 1)
//
//                TextField("", text: $text5)
//                    .textFieldStyle(DigitTextFieldStyle())
//                    .keyboardType(.numberPad)
//                    .focused($focusedField, equals: .d5)
//                    .opacity(codeValid ? 0 : 1)
//
//                TextField("", text: $text6)
//                    .textFieldStyle(DigitTextFieldStyle())
//                    .keyboardType(.numberPad)
//                    .focused($focusedField, equals: .d6)
//                    .opacity(codeValid ? 0 : 1)
//                Spacer()
//
//            }
//            Text(message)
//        }
//        Spacer()
//            .padding()
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                    focusedField = .d1
//                }
//            }
//            .onChange(of: text1) { _ in
//                focusedField = .d2
//                allDigits = text1
//            }
//            .onChange(of: text2) { _ in
//                focusedField = .d3
//                allDigits += text2
//            }
//            .onChange(of: text3) { _ in
//                focusedField = .d4
//                allDigits += text3
//            }
//            .onChange(of: text4) { _ in
//                focusedField = .d5
//                allDigits += text4
//            }
//            .onChange(of: text5) { _ in
//                focusedField = .d6
//                allDigits += text5
//            }
//            .onChange(of: text6) { _ in
//                focusedField = nil
//                allDigits += text6
//                verifyInput()
//            }
//
//        Spacer()
//        Button {
//            AuthViewModel.verifyCode(code: verificationCode) { error in
//
//                if error == nil {
//                    print("Next button registered")
//                    DatabaseService().checkUserProfile { exists in
//
//                        if exists {
//                            isOnboarding = false
//                        }
//                        else {
//                            currentStep = .profile
//                        }
//                    }
//                }
//                else {
//                    //TODO: show error
//                    print("wrong answer")
//
//                }
//            }
//
//        } label: {
//            Text("Next")
//        }
//        .buttonStyle(OnboardingButton())
//        .padding(.top, 32)
//   }
//
//    func verifyInput() {
//        print("'\(allDigits)'")
//        if allDigits == masterCode {
//            message = "Code accepted"
//            codeValid = true
//        } else {
//            message = "Code rejected. Try Again."
//            focusedField = .d1
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                allDigits = ""
//                text1 = ""
//                text2 = ""
//                text3 = ""
//                text4 = ""
//                text5 = ""
//                text6 = ""
//                message = "Enter code"
//            }
//        }
//    }
    
    
    /////////////////////////////////////////////////////////  --  --  -- Self discovered solution below -- -- Course provided solution above.
    
    
    
    //    @State var no1: String = ""
    //    @State var no2: String = ""
    //    @State var no3: String = ""
    //    @State var no4: String = ""
    //    @State var no5: String = ""
    //    @State var no6: String = ""
    //
    //    enum Field {
    //        case no1
    //        case no2
    //        case no3
    //        case no4
    //        case no5
    //        case no6
    //    }
    //
    //    @FocusState private var focusedField: Field?
    //
    //    var body: some View {
    //
    //        VStack {
    //
    //            Text("Verification")
    //                .font(Font.mainTitle)
    //                .padding(.top, 52)
    //
    //            Text("Enter the 6-digit verification code we sent to your device.")
    //                .font(Font.bodyParagraph)
    //                .padding(.top, 12)
    //                .padding()
    //
    //            VStack {
    //                ZStack {
    //                    HStack {
    //
    //                        TextField("", text: $no1)
    //                            .padding()
    //                            .background(Color("input"))
    //                            .foregroundColor(Color.black)
    //                            .frame(width: 50)
    //                            .cornerRadius(5.0)
    //                            .multilineTextAlignment(.center)
    //                            .keyboardType(.numberPad)
    //                        //                        TextField { textField in
    //                        //                            textField.becomeFirstResponder()
    //                        //                        }
    //                            .focused($focusedField, equals: .no1)
    //                            .onChange(of: no1) { newValue in
    //                                if newValue.count == 1 {
    //                                    focusedField = .no2
    //                                }
    //                            }
    //
    //                        TextField("", text: $no2)
    //                            .padding()
    //                            .background(Color("input"))
    //                            .foregroundColor(Color.black)
    //                            .frame(width: 50)
    //                            .cornerRadius(5.0)
    //                            .multilineTextAlignment(.center)
    //                            .keyboardType(.numberPad)
    //                            .focused($focusedField, equals: .no2)
    //                            .onChange(of: no2) { newValue in
    //                                if newValue.count == 1 {
    //                                    focusedField = .no3
    //                                }
    //                            }
    //
    //                        TextField("", text: $no3)
    //                            .padding()
    //                            .background(Color("input"))
    //                            .foregroundColor(Color.black)
    //                            .frame(width: 50)
    //                            .cornerRadius(5.0)
    //                            .multilineTextAlignment(.center)
    //                            .keyboardType(.numberPad)
    //                            .focused($focusedField, equals: .no3)
    //                            .onChange(of: no3) { newValue in
    //                                if newValue.count == 1 {
    //                                    focusedField = .no4
    //                                }
    //                            }
    //
    //                        TextField("", text: $no4)
    //                            .padding()
    //                            .background(Color("input"))
    //                            .foregroundColor(Color.black)
    //                            .frame(width: 50)
    //                            .cornerRadius(5.0)
    //                            .multilineTextAlignment(.center)
    //                            .keyboardType(.numberPad)
    //                            .focused($focusedField, equals: .no4)
    //                            .onChange(of: no4) { newValue in
    //                                if newValue.count == 1 {
    //                                    focusedField = .no5
    //                                }
    //                            }
    //
    //                        TextField("", text: $no5)
    //                            .padding()
    //                            .background(Color("input"))
    //                            .foregroundColor(Color.black)
    //                            .frame(width: 50)
    //                            .cornerRadius(5.0)
    //                            .multilineTextAlignment(.center)
    //                            .keyboardType(.numberPad)
    //                            .focused($focusedField, equals: .no5)
    //                            .onChange(of: no5) { newValue in
    //                                if newValue.count == 1 {
    //                                    focusedField = .no6
    //                                }
    //                            }
    //
    //                        TextField("", text: $no6)
    //                            .padding()
    //                            .background(Color("input"))
    //                            .foregroundColor(Color.black)
    //                            .frame(width: 50)
    //                            .cornerRadius(5.0)
    //                            .multilineTextAlignment(.center)
    //                            .keyboardType(.numberPad)
    //                            .focused($focusedField, equals: .no6)
    //                    }
    //
    

