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
    
    @State var no1: String = ""
    @State var no2: String = ""
    @State var no3: String = ""
    @State var no4: String = ""
    @State var no5: String = ""
    @State var no6: String = ""
    
    enum Field {
        case no1
        case no2
        case no3
        case no4
        case no5
        case no6
    }
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        
            VStack {
                
                Text("Verification")
                    .font(Font.mainTitle)
                    .padding(.top, 52)
                   
                Text("Enter the 6-digit verification code we sent to your device.")
                    .font(Font.bodyParagraph)
                    .padding(.top, 12)
                    .padding()
                
                
                ZStack {
                    HStack {
                        
                        TextField("", text: $no1)
                            .padding()
                            .background(Color("text-input"))
                            .foregroundColor(Color("text-input"))
                            .frame(width: 50)
                            .cornerRadius(5.0)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
//                        TextField { textField in
//                            textField.becomeFirstResponder()
//                        }
                        .focused($focusedField, equals: .no1)
                        .onChange(of: no1) { newValue in
                            if newValue.count == 1 {
                                focusedField = .no2
                            }
                        }
                        
                        
                        TextField("", text: $no2)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(Color.black)
                            .frame(width: 50)
                            .cornerRadius(5.0)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .no2)
                            .onChange(of: no2) { newValue in
                                if newValue.count == 1 {
                                    focusedField = .no3
                                }
                            }
                        
                        TextField("", text: $no3)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(Color.black)
                            .frame(width: 50)
                            .cornerRadius(5.0)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .no3)
                            .onChange(of: no3) { newValue in
                                if newValue.count == 1 {
                                    focusedField = .no4
                                }
                            }
                        
                        TextField("", text: $no4)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(Color.black)
                            .frame(width: 50)
                            .cornerRadius(5.0)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .no4)
                            .onChange(of: no4) { newValue in
                                if newValue.count == 1 {
                                    focusedField = .no5
                                }
                            }
                        
                        TextField("", text: $no5)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(Color.black)
                            .frame(width: 50)
                            .cornerRadius(5.0)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .no5)
                            .onChange(of: no4) { newValue in
                                if newValue.count == 1 {
                                    focusedField = .no6
                                }
                            }
                        
                        
                        
                        TextField("", text: $no6)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(Color.black)
                            .frame(width: 50)
                            .cornerRadius(5.0)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .no6)
                        
                        
                    }
                    
                }
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
                            Button {
                                currentStep = .profile
                
                            } label: {
                                Text("Next")
                
                
                            }
                            .buttonStyle(OnboardingButton())
                            .padding(.bottom, 64)
            }
            
        }
        
    }


//    var body: some View {
//
//        VStack {
////
//            Text("Verification")
//                .font(Font.mainTitle)
//                .padding(.top, 52)
//            Text("Enter the 6-digit verification code we sent to your device..")
//                .font(Font.bodyParagraph)
//                .padding(.top, 12)
//
//            ZStack {
//                Rectangle()
//                    .frame(height: 56)
//                    .cornerRadius(5)
//                    .font(Font.subheadline)
//                    .padding(.horizontal)
//                    .foregroundColor(Color("input"))
//
//
//                Spacer()
//                HStack {
//
//                    TextField("", text: $verificationCode )
//                        .foregroundColor(Color("text-input"))
//                        .font(Font.bodyParagraph)
//                        .padding(.leading, 32)
//                    Spacer()
//
//                }
//                .padding()
//            }
//            .padding(.top, 34)
//
//            Spacer()
//
//            Button {
//                currentStep = .profile
//
//            } label: {
//                Text("Next")
//
//
//            }
//            .buttonStyle(OnboardingButton())
//        }
//        .padding(.bottom, 64)
//
//    }


struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(currentStep: .constant(.profile))
    }
}
