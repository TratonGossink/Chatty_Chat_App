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
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    
    @State var isSourceMenuShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    @State var isSavedButtonDisabled = false
    
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
                
                isSourceMenuShowing = true
                
            } label: {
                
                ZStack {
                    
                    if selectedImage != nil {
                        
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                        
                    } else {
                        Circle()
                            .foregroundColor(Color.white)
                        Image(systemName: "camera.fill")
                            .tint(Color("icons-input"))
                    }
                    Circle()
                        .stroke(Color("create-profile-border"), lineWidth: 2)
                    
                }
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
                
                //TODO: Ensure both fields are filled out
                
                //Preventing double tapping of button
                isSavedButtonDisabled = true
                
                DatabaseService().setUserProfile(firstName: firstName, lastName: lastName, image: selectedImage) { isSuccess in
                    if isSuccess {
                        currentStep = .contacts
                        print("Success")
                    }
                    else {
                        currentStep = .contacts
                        print("Failed")
                    }
                   
                    isSavedButtonDisabled = false
                }
            } label: {
                Text(isSavedButtonDisabled ? "Uploading" : "Save")
            }
            .buttonStyle(OnboardingButton())
            .disabled(isSavedButtonDisabled)
            .padding(.bottom, 64)
            
        }
        .confirmationDialog("From where?", isPresented: $isSourceMenuShowing, actions: {
            
            Button {
                // Set source to photo library
                
                self.source = .photoLibrary
                isPickerShowing = true
                
            } label: {
                Text("Photo Library")
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                Button {
                    //Set source to camera
                    self.source = .camera
                    
                    isPickerShowing = true
                } label: {
                    Text("Take Photo")
                }
            }
            
        })
        .sheet(isPresented: $isPickerShowing) {
            
            ImagePicker(selectedImage: $selectedImage,
                        isPickerShowing: $isPickerShowing, source: self.source)
            
        }
        
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(currentStep: .constant(.profile))
    }
}
