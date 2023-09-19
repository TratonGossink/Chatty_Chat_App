//
//  ContactsPicker.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 9/11/23.
//

import SwiftUI

struct ContactsPicker: View {
    
    @Binding var isContactPickerShowing: Bool
    @Binding var selectedContact: [UserInfo]
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    var body: some View {
        
        ZStack {
            
            Color("background")
                .ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                ScrollView {
                    
                    ForEach(contactsViewModel.filteredUser) { user in
                        
                        if user.isactive {
                            
                            let isSelectedContact = selectedContact.contains { u in
                                 u.id == user.id
                             }
                             
                             ZStack {
                                 ContactRow(user: user)
                                   
                                 HStack {
                                     Spacer()
                                     
                                     Button {
                                         //Tapping button will toggle checkmark
                                         if isSelectedContact {
                                             
                                             //Find index of contact within array
                                             let index = selectedContact.firstIndex(of: user)
                                             
                                             //Remove contact from selected pool
                                             if let index = index {
                                                 selectedContact.remove(at: index)
                                             }
                                         }
                                         else {
                                             
                                             //Impose limit of 3
                                             if selectedContact.count < 3 {
                                                 
                                                 //Select contact
                                                 selectedContact.append(user)
                                             }
                                             else {
                                                 //TODO: Show message of limit reached
                                             }
                                         }
                                     }
                                         label: {
                                             Image(systemName: isSelectedContact ? "checkmark.circle.fill" : "checkmark.circle")
                                                 .resizable()
                                                 .foregroundColor(Color("button-primary"))
                                                 .frame(width: 25, height: 25)
                                         
                                     }

                                 }
                             }
                             .padding(.top, 18)
                             .padding(.horizontal)
                            
                        }
                        
             
                    }
                }
                
                Button {
                    //Dismisses contact view
                    isContactPickerShowing = false
                } label: {
                    
                    ZStack {
                        Color("button-primary")
                            
                        Text("Done")
                            .font(Font.buttonText)
                            .foregroundColor(Color("text-button"))
                    }
                    
                }
                .frame(height: 56)
                
            }
            .padding(.top, 12)
        }
        .onAppear {
            //Clears any filters
            contactsViewModel.filterContacts(filterBy: "")
        }
      
    }
}


