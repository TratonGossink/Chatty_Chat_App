//
//  ChatsListView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/11/23.
//

import SwiftUI

struct ChatsListView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Binding var isChatShowing: Bool
    
    var body: some View {
        
        if chatViewModel.chats.count > 0 {
            
            List(chatViewModel.chats) { chat in
                
                Button {
                    //Set selected chat for viewmodel
                    chatViewModel.selectedChat = chat
                    
                    isChatShowing = true
                    
                } label: {
                    Text(chat.id ?? "No chat id.")
                }
            }
            
        }
        else {
            Text("No chats.")
        }
    }
}

struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView(isChatShowing: .constant(false))
    }
}
