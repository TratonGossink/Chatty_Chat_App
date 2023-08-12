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
                    .font(Font.mainTitle)
                Spacer()
                Button {
                    //TODO: contact info
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(Color("icon-secondary"))
                }
            }
            
            ZStack {
                
                Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    
                TextField("Search contact or number", text: $filterText)
                    .padding()
            }
            .frame(width: 46)
            List(contactsViewModel.users) { user in 
                
            }
        }
    }
}

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView()
    }
}
