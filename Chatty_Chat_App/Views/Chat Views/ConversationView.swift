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
    
    @State var isContactPickerShowing = false
    
    @State var chatMessage = ""
    
    @State var participants = [UserInfo]()
    
    var body: some View {
        
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                //Chat Header
                ZStack {
                    Color("header-background")
                        .ignoresSafeArea()
                       
                    HStack {
                        
                        VStack (alignment: .leading){
                            HStack {
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
                                //Label for new message
                                if participants.count == 0 {
                                    Text("New Message")
                                        .font(Font.mainHeading)
                                        .foregroundColor(Color("text-header"))
                                }
                            }
                            .padding(.bottom, 16)
                            
                            //User Name or Title of Chat
                            
                            if participants.count > 0 {
                                
                                let participant = participants.first
                                
                                Group {
                                    if participants.count == 1 {
                                        
                                        Text("\(participant?.firstname ?? "") \(participant?.lastname ?? "")")
                                        
                                    }
                                    else if participants.count == 2 {
                                        
                                        let participant2 = participants[1]
                                        
                                        Text("\(participant?.firstname ?? ""), \(participant2.firstname ?? "")")
                                        
                                    }
                                    else if participants.count > 2 {
                                        
                                        let participant2 = participants[1]
                                        
                                        Text("\(participant?.firstname ?? ""), \(participant2.firstname ?? "") + \(participants.count - 2) others")
                                        
                                    }
                                }
                                .font(Font.subHeading)
                                .foregroundColor(Color("text-header"))
                            }
                                    
                            else {
                                //New message
                                Text("Recipient")
                                    .font(Font.bodyParagraph)
                                    .foregroundColor(Color("text-input"))
                            }
                        }
                        Spacer()
                        
                        //Profile Image
                        if participants.count > 0 {
                            
                            let participant = participants.first
                             
                            
                            ProfilePicView(user: participant!)
                        }
                        else if participants.count > 1 {
                            //Dislays group profile images
                            GroupProfilePicView(users: participants)
                            
                        }
                        else {
                            //New message
                            Button {
                                //show contact picker
                                isContactPickerShowing = true
                                
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color("button-primary"))
                                    .frame(width: 25, height: 25)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
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
                                    else if participants.count > 1 {
                                        //Group chat and not from user - Display profile pic
                                        let userOfMsg = participants.filter { p in
                                            p.id == msg.sendid
                                        }.first
                                        if let userOfMsg = userOfMsg {
                                            ProfilePicView(user: userOfMsg)
                                                .padding(.trailing, 16)
                                        }
                                    }
                                    
                                    let userOfMsg = participants.filter { p in
                                        p.id == msg.sendid
                                    }.first
                                    if msg.imageurl != "" {
                                        
                                        //Photo message
                                        ConversationPhotoMessage(imageUrl: msg.imageurl!, isFromUser: isFromUser, isActive: userOfMsg?.isactive ?? true)
                                    }
                                    else {
                                        //Need to distinguish if group chat or existing message from an existing user
                                        if participants.count > 1 && !isFromUser {
                                            
                    
                                            //Show msg with name
                                            ConversationTextMessage(msg: msg.msg, isFromUser: isFromUser, name: "\(userOfMsg?.firstname ?? "") \(userOfMsg?.lastname ?? "")", isActive: userOfMsg?.isactive ?? true)
                                        }
                                        else {
                                            //Text Message
                                            ConversationTextMessage(msg: msg.msg, isFromUser: isFromUser)
                                        }
                                    }
                                    
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
                    //Text Field
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(Color("date-pill"))
                            .cornerRadius(22)
                        
                        if selectedImage != nil {
                            
                            //Displays image in message bar
                            Text("Image")
                                .foregroundColor(Color("text-input"))
                                .font(Font.bodyParagraph)
                                .padding(10)
                            //Delete button
                            HStack {
                                Spacer()
                                Button {
                                    //Delete image
                                    selectedImage = nil
                                    
                                } label: {
                                    Image(systemName: "xmark.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color("icons-input"))
                                }
                                
                            }
                            .padding(.trailing, 12)
                            
                        }
                        else {
                            
                            TextField("Type your message", text: $chatMessage)
                                .foregroundColor(Color("text-input"))
                                .font(Font.bodyParagraph)
                                .placeholder(when: chatMessage.isEmpty) {
                                    Text("Type your message.")
                                        .foregroundColor(Color("text-searchfield"))
                                        .font(Font.bodyParagraph)
                                }
                                .padding(10)
                        }
                    }
                    .frame(height: 44)
                    
                    //Send button
                    Button {
                        
                        //Send image if image is selected
                        if selectedImage != nil {
                            //Send image
                            chatViewModel.sendPhotoMessage(image: selectedImage!)
                            //Clears image
                            selectedImage = nil
                        }
                        //Send text message
                        else {
                            
                            //Cleans text msg
                            chatMessage = chatMessage.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            //Send message
                            chatViewModel.sendMessage(msg: chatMessage)
                            
                            //Clears text box
                            chatMessage = ""
                            
                        }
                        
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("bubble-primary"))
                    }
                    .disabled(chatMessage.trimmingCharacters(in: .whitespacesAndNewlines) == "" && selectedImage == nil)
                    
                }
                .disabled(participants.count == 0)
                .padding(.horizontal)
                .frame(height: 76)
            }
            
        }
        .onAppear {
            
            //Call view model to retrieve all chat messages
            chatViewModel.getMessages()
            
            //Get other user instances, not including the logged in user
            let ids = chatViewModel.getParticipantIds()
            self.participants = contactsViewModel.getParticipant(ids: ids)
        }
        .onDisappear {
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
        .sheet(isPresented: $isPickerShowing) {
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, source: self.source)
        }
        .sheet(isPresented: $isContactPickerShowing) {
            //Sheet dismissed
           
            if participants.count > 0 {
                //Searches for conversation with selected participants
                chatViewModel.searchForChat(contacts: participants)
            }
            
        } content: {
            ContactsPicker(isContactPickerShowing: $isContactPickerShowing, selectedContact: $participants)
        }

    }
}


struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatShowing: .constant(true))
    }
}
