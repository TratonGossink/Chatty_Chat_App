//
//  CreateProfileView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/31/23.
//

import SwiftUI

struct CreateProfileView: View {
    
    @Binding var currentStep: OnboardingStep
    
    @State var firstName = ""
    @State var lastName = ""
    
    
    var body: some View {
        
        VStack {
            
            Text("Set Up Your Profile")
                .font(Font.mainTitle)
                .padding(.top, 52)
            Text("Just a few more steps to get started")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            Spacer()
            
            Button {
                //show action sheet
            } label: {
                
                ZStack {
                    
                    Circle()
                        .foregroundColor(Color.white)
                    Circle()
                        .stroke(Color("profile-image-border"), lineWidth: 2)
                    Image(systemName: "camera.fill")
                        .tint(Color("icons-input"))
                        .frame(width: 48, height: 36)
                }
                .padding(.top, 36)
                .frame(width: 134, height: 134)
            }
            
            Spacer()
            //First Name
            TextField("First name", text: $firstName)
                .textFieldStyle(profileTextFieldStyle())
            //Last Name
            TextField("Last name", text: $lastName)
                .textFieldStyle(profileTextFieldStyle())
            Spacer()
            Button {
                currentStep = .contacts
            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButton())
            .padding(.bottom, 64)
        }
        
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(currentStep: .constant(.contacts))
    }
}
