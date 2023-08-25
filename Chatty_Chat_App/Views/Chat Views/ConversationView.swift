//
//  ConversationView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/15/23.
//

import SwiftUI

struct ConversationView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Binding var isChatShowing: Bool
    
    @State var chatMessage = ""
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            //Back arrow and name
            HStack {
                
                VStack (alignment: .leading){
                    
                    Button {
                        
                        isChatShowing = false
                        
                    } label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color("text-header"))
                    }
                    .padding(.bottom, 16)
                    Text("Some User")
                        .font(Font.subHeading)
                    
                }
                Spacer()
                .padding(.horizontal)
               
                ProfilePicView(user: UserInfo())
                
            }
            .frame(height: 96)
            .padding()
            
            //Chat log
            ScrollView {
                
                VStack (spacing: 24) {
                    
                    ForEach (chatViewModel.messages) { msg in
                        
                        let isFromUser = msg.sendid == AuthViewModel.getLoggedInUserId()
                        
                        // Dynamic message
                        HStack {
                            
                            if isFromUser {
                                // Timestamp
                                Text(DateHelper.chatTimestampFrom(date: msg.timestamp))
                                    .font(Font.caption)
                                    .foregroundColor(Color("text-input"))
                                    .padding(.trailing)
                                
                                Spacer()
                            }
                            
                            // Message
                            Text(msg.msg)
                                .font(Font.bodyParagraph)
                                .foregroundColor(isFromUser ? Color("text-button") : Color("text-primary"))
                                .padding(.vertical, 16)
                                .padding(.horizontal, 24)
                                .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
                                .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                            
                            if !isFromUser {
                                
                                Spacer()
                                
                                Text(DateHelper.chatTimestampFrom(date: msg.timestamp))
                                    .font(Font.caption)
                                    .foregroundColor(Color("text-input"))
                                    .padding(.leading)
                            }
                            
                        }
                        
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, 24)
                
            }
            .background(Color("background"))
            
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                HStack(spacing: 2.5) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color("icons-secondary"))
                    }
                    .padding(.trailing)
                    
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(Color("date-pill"))
                            .cornerRadius(22)
                        
                        TextField("Type your message", text: $chatMessage)
                            .foregroundColor(Color("text-input"))
                            .font(Font.bodyParagraph)
                            .padding(10)
                
                   
                    
                    HStack {
                        Spacer()
                        Button {
                            //
                        } label: {
                            Image(systemName: "face.smiling")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color("icons-input"))
                        }
                        
                        
                    }
                    .padding(.trailing, 12)
                }
                .frame(height: 44)
                    Button {
                        //Function
                        
                        chatViewModel.sendMessage(msg: chatMessage)
                        
                        chatMessage = ""

                    } label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("bubble-primary"))
                    }
                    
                }
                .padding(.horizontal)
            }
            .frame(height: 76)
        }
        .onAppear {
            chatViewModel.getMessages()
            
        }

    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatShowing: .constant(false))
    }
}
