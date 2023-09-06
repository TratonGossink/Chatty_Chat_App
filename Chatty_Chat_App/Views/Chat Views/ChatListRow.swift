//
//  ChatListRow.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 9/4/23.
//

import SwiftUI

struct ChatListRow: View {
    
    var chat: Chat
    
    var otherParticipants: [UserInfo]?
    
    var body: some View {
    
            HStack(spacing: 18) {
                
                //Factor in for additional participant(s)
                let participant = otherParticipants?.first
                //Profile image of participant
                if participant != nil {
                    ProfilePicView(user: participant!)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text(participant == nil ? "Unknown" : "\(participant!.firstname ?? "") \(participant!.lastname ?? "")")
                        .font(Font.subHeading)
                        .foregroundColor(Color(.black))
                }
                Spacer()
                    Text(chat.updated == nil ? "" : DateHelper.chatTimestampFrom(date: chat.updated!))
                        .font(Font.subheadline)
                        .foregroundColor(Color("text-input"))
               
            }
        
        
    }
}


