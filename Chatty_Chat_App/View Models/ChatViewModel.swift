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
    
    func clearSelectedChat() {
        
        self.selectedChat = nil
        self.messages.removeAll()
    }
    
    //MARK: - Database Methods
    
    func getChats() {
        
        dbService.getAllChats { chats in
            
            self.chats = chats
        }
        
    }
    //Searches for chat for selected contact and displays existing chat or creates new chat if on existing chat.
    func searchForChat(contacts: [UserInfo]) {
        
        for contact in contacts  {
            if contact.id == nil {return}
        }
        
        //Create set from ids of contacts passed in
        let setOfContactIds = Set(contacts.map { u in u.id!})
            
            let foundChat = chats.filter { chat in
            
            let setOfParticipantIds = Set(chat.participantsid)
            
            return chat.numparticipants == contacts.count + 1 && setOfContactIds.isSubset(of: setOfParticipantIds)
            
        }
        //Chat between user and contact
        if !foundChat.isEmpty {
            
            self.selectedChat = foundChat.first!
            //Fetch messages
            getMessages()
            
        }
        else {
            
            //Create array of ids of all participants
            var allParticipantIds = contacts.map { u in u.id!}
            allParticipantIds.append(AuthViewModel.getLoggedInUserId())
            
            //No existing chat and creating new chat
            let newChat = Chat(id: nil, numparticipants: allParticipantIds.count, participantsid: allParticipantIds, lastmsg: nil, updated: nil, msgs: nil)
            //Set as selected chat
            self.selectedChat = newChat
            
            //Saves new chat to database
            dbService.createChat(chat: newChat) { docId in
                
                // Set doc id from the auto generated document in the database
                self.selectedChat = Chat(id: docId,
                                         numparticipants: allParticipantIds.count,
                                         participantsid: allParticipantIds,
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
    
    func sendPhotoMessage(image: UIImage) {
        // Check that we have a selected chat
        guard selectedChat != nil else {
            return
        }
        
        dbService.sendPhotoMessage(image: image, chat: selectedChat!)
        
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
