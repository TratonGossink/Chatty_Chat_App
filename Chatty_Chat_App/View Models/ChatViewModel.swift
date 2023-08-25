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
    
    func getChats() {
        
        dbService.getAllChats { chats in
            
            self.chats = chats
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
    
    
}
