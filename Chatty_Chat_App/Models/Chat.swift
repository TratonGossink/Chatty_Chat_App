//
//  Chat.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/21/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Chat: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var numparticipants: Int
    
    var participantsid: [String]
    
    var lastmsg: String?
    
    @ServerTimestamp var updated: Date?
    
    var msgs: [ChatMessage]?
    
}


struct ChatMessage: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var imageurl: String?
    
    var msg: String
    
    @ServerTimestamp var timestamp: Date?
    
    var sendid: String
    
}
