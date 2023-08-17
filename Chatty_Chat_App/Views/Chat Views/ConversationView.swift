//
//  ConversationView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/15/23.
//

import SwiftUI

struct ConversationView: View {
    
    @Binding var isChatShowing: Bool
    
    @State var chatMessage = ""
    
    var body: some View {
        
        VStack {
            
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
            
            ScrollView() {
             
                VStack (spacing: 24) {
                    
                    HStack {
                        
                        Text("9:41 pm")
                            .font(Font.caption)
                            .foregroundColor(Color("text-searchfield"))
                            .padding(.leading)
                        
                        Spacer()
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam")
                            .font(Font.bodyParagraph)
                            .foregroundColor(Color("input"))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            .background(Color("bubble-primary"))
                            .cornerRadius(20, corners: [.topLeft, .topRight, .bottomLeft])
                    }
                    
                    //Incoming message
                    HStack {
                        
                        Text("Lorem ipsum dolor sit amet")
                            .font(Font.bodyParagraph)
                            .foregroundColor(Color("text-primary"))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            .background(Color("bubble-secondary"))
                            .cornerRadius(20, corners: [.topLeft, .topRight, .bottomRight])
                        Spacer()
                        
                        Text("9:41 pm")
                            .font(Font.caption)
                            .foregroundColor(Color("text-searchfield"))
                            .padding(.trailing)
                    }
              
                    //Outgoing message
                    HStack {
                        
                        
                    }
                    
                    
                }
                .padding(.horizontal)
                .padding(.top, 24)
      
            }
            .background(Color("background"))
            
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                HStack {
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
    
        
        
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatShowing: .constant(false))
    }
}
