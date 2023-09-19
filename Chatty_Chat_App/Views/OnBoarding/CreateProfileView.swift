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
    @State var isErrorVisible = false
    
    @State var errorMessage = ""
    
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
                .placeholder(when: firstName.isEmpty) {
                    Text("First Name")
                        .foregroundColor(Color("text-searchfield"))
                        .font(Font.bodyParagraph)
                }
            
            //Last Name
            TextField("Last name", text: $lastName)
                .textFieldStyle(profileTextFieldStyle())
                .placeholder(when: lastName.isEmpty) {
                    Text("Last Name")
                        .foregroundColor(Color("text-searchfield"))
                        .font(Font.bodyParagraph)
                }
            
            //    //Error label
            Text(errorMessage)
                .foregroundColor(.red)
                .font(Font.bodyParagraph)
                .padding(.top, 20)
                .opacity(isErrorVisible ? 1 : 0)
            
            Spacer()
            
            Button {
                
                //Hide error message
                isErrorVisible = false
                
                //Check for valid first name and last name input
                guard !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
                        !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                else {
                    
                    errorMessage = "Please enter a valid first and last name."
                    isErrorVisible = true
                    return
                }
                
                //Preventing double tapping of button
                isSavedButtonDisabled = true
                
                DatabaseService().setUserProfile(firstName: firstName, lastName: lastName, image: selectedImage) { isSuccess in
                    if isSuccess {
                        currentStep = .contacts
                   
                    }
                    else {
                        //Show error message
                        errorMessage = "Error occured, Please try again."
                      isErrorVisible = true
                        
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
