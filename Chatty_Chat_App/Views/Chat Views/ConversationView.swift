//
//  ConversationView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/15/23.
//

import SwiftUI

struct ConversationView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @Binding var isChatShowing: Bool
    
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    
    @State var isSourceMenuShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    @State var chatMessage = ""
    
    @State var participants = [UserInfo]()
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            //Back arrow and name
            HStack {
                
                VStack (alignment: .leading){
                    //Back arrow
                    Button {
                        
                        //Dismissees existing chat
                        isChatShowing = false
                        
                    } label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color("text-header"))
                    }
                    .padding(.bottom, 16)
                    
                    //User Name or Title of Chat
                    
                    if participants.count > 0 {
                        
                        let participant = participants.first
                        
                        Text("\(participant?.firstname ?? "")")
                            .font(Font.subHeading)
                            .foregroundColor(Color("text-header"))
                        
                    }
                }
                Spacer()
                
                //Profile Image
                if participants.count > 0 {
                    
                    let participant = participants.first
                    
                    ProfilePicView(user: participant!)
                }
            }
            .padding(.horizontal)
            .frame(height: 96)
            
            //Chat log
            //MARK: - Chat Window Log
            
            ScrollViewReader { proxy in
                
            
            
            ScrollView {
                
                
                VStack (spacing: 24) {
                    
                    ForEach (Array(chatViewModel.messages.enumerated()), id: \.element) { index, msg in
                        
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
                            
                            // Message bubble
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
                        .id(index)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, 24)
                
            }
            .background(Color("background"))
            .onChange(of: chatViewModel.messages.count) { newCount in
                
                withAnimation {
                    proxy.scrollTo(newCount - 1)
                }
            }
        }
            //Chat Message Bar
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                //Message Bar
                HStack(spacing: 2.5) {
                    //Camera Button
                    Button {
                        
                        isSourceMenuShowing = true 
                        
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
                    
                    //Send button
                    Button {
                        
                        chatMessage = chatMessage.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        //Send message
                        chatViewModel.sendMessage(msg: chatMessage)
                        
                        //Clears text box
                        chatMessage = ""

                    } label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("bubble-primary"))
                    }
                    .disabled(chatMessage.trimmingCharacters(in: .whitespacesAndNewlines) == "")
                    
                }
                .padding(.horizontal)
            }
            .frame(height: 76)
        }
        .onAppear {
            
            //Call view model to retrieve all chat messages
            chatViewModel.getMessages()
            
            //Get other user instances, not including the logged in user
            let ids = chatViewModel.getParticipantIds()
            self.participants = contactsViewModel.getParticipant(ids: ids)
        }
        .onDisappear() {
            //Cleans before conversation view clears
            chatViewModel.ConversationViewCleanup()
        }
        .confirmationDialog("From where?", isPresented: $isSourceMenuShowing, actions: {
            
            Button {
                // Set source to photo library
                
                self.source = .photoLibrary
                isPickerShowing = true
                
            } label: {
                Text("Photo Library")
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                Button {
                    //Set source to camera
                    self.source = .camera
                    
                    isPickerShowing = true
                } label: {
                    Text("Take Photo")
                }
            }
            
        })

    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatShowing: .constant(true))
    }
}
