//
//  ConversationTextMessage.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 9/8/23.
//

import SwiftUI

struct ConversationTextMessage: View {
    
    var msg: String
    var isFromUser: Bool
    var name: String?
    var isActive: Bool = true
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 4) {
            //Name
            if let name = name {
                Text(name)
                    .font(Font.chatName)
                    .foregroundColor(Color("bubble-primary"))
            }
            //Message
            Text(isActive ? msg : "Message Deleted")
                .font(Font.bodyParagraph)
                .foregroundColor(isFromUser ? Color("text-button") : Color("incoming-text"))
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
        .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
    }
}
struct ConversationTextMessage_Previews: PreviewProvider {
    static var previews: some View {
        ConversationTextMessage(msg: "Test", isFromUser: true)
    }
}
