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
                    
                    //Profile image of participants
                    if otherParticipants != nil && otherParticipants!.count == 1 {

                    //Profile image of participant
                    if participant != nil {
                        ProfilePicView(user: participant!)
                    }
                }
                    else if otherParticipants != nil && otherParticipants!.count > 1 {
                        //Display group image
                        GroupProfilePicView(users: otherParticipants!)
                        
                    }
                        
                VStack(alignment: .leading, spacing: 12) {
                    //Name
                    if let otherParticipants = otherParticipants {
                        
                        Group {
                            if otherParticipants.count == 1 {
                                
                                Text("\(participant!.firstname ?? "") \(participant!.lastname ?? "")")
                                   
                            }
                            else if otherParticipants.count == 2 {
                                
                                let participant2 = otherParticipants[1]
                                
                                Text("\(participant!.firstname ?? ""), \(participant!.firstname ?? "")")
                                  
                            }
                            else if otherParticipants.count > 2 {
                                
                                let participant2 = otherParticipants[1]
                                
                                Text("\(participant!.firstname ?? ""), \(participant!.firstname ?? "") + \(otherParticipants.count - 2) others")
                                
                            }
                        }
                        .font(Font.subHeading)
                        .foregroundColor(Color(.black))
                    }
                }
                Spacer()
                    Text(chat.updated == nil ? "" : DateHelper.chatTimestampFrom(date: chat.updated!))
                        .font(Font.subheadline)
                        .foregroundColor(Color("text-input"))
               
            }
        
        
    }
}


