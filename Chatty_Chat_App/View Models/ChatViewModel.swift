//
//  ChatViewModel.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/21/23.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    
    @Published var chats = [Chat]()
    
    @Published var selectedChat: Chat?
    
    @Published var messages = [ChatMessage]()
    
    var dbService = DatabaseService()
    
    init() {
        
        getChats()
        
    }
    
    //MARK: - Database Methods
    
    func getChats() {
        
        dbService.getAllChats { chats in
            
            self.chats = chats
        }
        
    }
    //Searches for chat for selected contact and displays existing chat or creates new chat if on existing chat.
    func searchForChat(contact: UserInfo) {
        
        guard contact.id != nil else {
            return
        }
        
        let foundChat = chats.filter { chat in
            
            return chat.numparticipants == 2 && chat.participantsid.contains(contact.id!)
            
        }
        //Chat between user and contact
        if !foundChat.isEmpty {
            
            self.selectedChat = foundChat.first!
            //Fetch messages
            getMessages()
            
        }
        else {
            //No existing chat and creating new chat
            let newChat = Chat(id: nil, numparticipants: 2, participantsid: [AuthViewModel.getLoggedInUserId(), contact.id!], lastmsg: nil, updated: nil, msgs: nil)
            //Set as selected chat
            self.selectedChat = newChat
            
            //Saves new chat to database
            dbService.createChat(chat: newChat) { docId in
                
                // Set doc id from the auto generated document in the database
                self.selectedChat = Chat(id: docId,
                                         numparticipants: 2,
                                         participantsid: [AuthViewModel.getLoggedInUserId(), contact.id!],
                                         lastmsg: nil, updated: nil, msgs: nil)
                
                // Add chat to the chat list
                self.chats.append(self.selectedChat!)
            }
        }
    }
    
    
    func getMessages() {
        
        guard selectedChat != nil else {
            return
        }
        
        dbService.getAllMessages(chat: selectedChat!) { msgs in
            
            self.messages = msgs
        }
    }
    
    func sendMessage(msg: String) {
        
        // Check that we have a selected chat
        guard selectedChat != nil else {
            return
        }
        
        dbService.sendMessage(msg: msg, chat: selectedChat!)
        
    }
    
    func ConversationViewCleanup() {
        dbService.detachConversationViewListeners()
    }
    
    func ChatViewCleanup() {
        dbService.detachChatListViewListeners()
    }

    
    //MARK: - Helper Methods
    
    ///Task in a list of user ids, removes the user from the list and returns remaining ids
    func getParticipantIds() -> [String] {
        
        guard selectedChat != nil else {
            return [String]()
        }
        //Filter out user ids
        let ids = selectedChat!.participantsid.filter { id in
            id != AuthViewModel.getLoggedInUserId()
        }
        return ids
    }
    
  
    
}
