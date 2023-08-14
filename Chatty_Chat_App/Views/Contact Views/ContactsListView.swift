//
//  ContactsListView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/11/23.
//

import SwiftUI

struct ContactsListView: View {
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @State var filterText = ""
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Contacts")
                    .font(Font.mainHeading)
                Spacer()
                Button {
                    //TODO: contact info
                } label: {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(Color("icons-secondary"))
                }
            }
            .padding(.top, 20)
            
            ZStack {
                Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    
                TextField("Search contact or number", text: $filterText)
                    .font(Font.bodyParagraph)
                    .tint(Color("text-searchfield"))
                    .padding()
            }
            .frame(height: 46)
            
            if contactsViewModel.users.count > 0 {
              
                List(contactsViewModel.users) { user in
                    
                    Text(user.firstname ?? "Sample User")
                        
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            else {
                
                Spacer()
                
                Image("no-contacts-yet")
                Text("Hmm...No contacts yet?")
                    .font(Font.mainHeading)
                    .padding(.top, 32)
                Text("Try adding some contacts from your phone!")
                    .font(Font.bodyParagraph)
                    .padding(.top, 8)
                Spacer()
                
            }
            
  
            
        }
        .padding(.horizontal)
        .onAppear {
            // Gather local contacts
            contactsViewModel.getLocalContacts()
        }
    }
}

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView()
    }
}
