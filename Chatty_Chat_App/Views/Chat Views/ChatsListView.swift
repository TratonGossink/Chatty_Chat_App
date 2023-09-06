//
//  ChatsListView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/11/23.
//

import SwiftUI

struct ChatsListView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @Binding var isChatShowing: Bool
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Chats")
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
            .padding(.horizontal)
            //Chat list
            if chatViewModel.chats.count > 0 {
                
                List(chatViewModel.chats) { chat in
                    
                    Button {
                        //Set selected chat for viewmodel
                        chatViewModel.selectedChat = chat
                        
                        isChatShowing = true
                        
                    } label: {
                        ChatListRow(chat: chat, otherParticipants: contactsViewModel.getParticipant(ids: chat.participantsid))
                        
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            else {
                Spacer()
                
                Image("no-chats-yet")
                Text("Hmm...No chats yet!")
                    .font(Font.mainHeading)
                    .padding(.top, 32)
                Text("Try starting a new chat with an existing contact!")
                    .font(Font.bodyParagraph)
                    .padding(.top, 8)
                Spacer()
            }
        }
       
    }
}

struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView(isChatShowing: .constant(false))
    }
}
