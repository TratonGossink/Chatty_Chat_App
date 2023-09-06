//
//  ContactsListView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/11/23.
//

import SwiftUI

struct ContactsListView: View {
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @State var filterText = ""
    
    @Binding var isChatShowing: Bool
    
    var body: some View {
        
        VStack {
            //Header
            HStack {
                Text("Contacts")
                    .font(Font.mainHeading)
                Spacer()
                
                Button {
                   //Settings
                } label: {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(Color("icons-secondary"))
                }
            }
            .padding(.top, 20)
            //Search Bar
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
            .onChange(of: filterText) { _ in
                contactsViewModel.filterContacts(filterBy: filterText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
            }
            
            if contactsViewModel.filteredUser.count > 0 {
                
                List(contactsViewModel.filteredUser) { user in
                    
                    Button {
                        
                        //Searches for existing chat with user
                        chatViewModel.searchForChat(contact: user)
                        //Display conversation view
                        isChatShowing = true
                        
                    } label: {
                        ContactRow(user: user)
                         
                    }
                    .listRowBackground(Color(.clear))
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .padding(.top, 12)
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

    }
}

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView(isChatShowing: .constant(false))
    }
}
