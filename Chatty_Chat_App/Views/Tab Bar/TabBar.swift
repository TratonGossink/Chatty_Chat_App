//
//  TabBar.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/29/23.
//

import SwiftUI


enum Tabs: Int {
     case chats = 0
     case contacts = 1
     
 }

struct TabBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        
        HStack(alignment: .center) {
            Button {
                
                selectedTab = .chats
                
            } label: {
                
                TabBarButton(buttonText: "Chats", imageName: "bubble.left", isActive: selectedTab == .chats)
                
//                GeometryReader { geo in
//
//                    if selectedTab == .chats {
//
//                    Rectangle()
//                        .foregroundColor(.blue)
//                        .frame(width: geo.size.width/2, height: 4)
//                        .padding(.leading, geo.size.width/4)
//                }
//                    VStack(alignment: .center, spacing: 4) {
//                        Image(systemName: "bubble.left")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 24, height: 24)
//                        Text("Chats")
//                            .font(Font.caption)
//                    }
//                    .frame(width: geo.size.width, height:
//                            geo.size.height)
//                }
                
            }
            .tint(Color("icons-secondary"))
            
            Button {
                
            } label: {
                
                VStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    Text("New Chat")
                        .font(Font.caption)
                }
            }
            .tint(Color("icons-primary"))
            
            Button {
                
                selectedTab = .chats
                
            } label: {
                TabBarButton(buttonText: "Contacts", imageName: "person", isActive: selectedTab == .contacts)
                
                
//                GeometryReader { geo in
//
//                    if selectedTab == .contacts{
//
//                        Rectangle()
//                            .foregroundColor(.blue)
//                            .frame(width: geo.size.width/2, height: 4)
//                            .padding(.leading, geo.size.width/4)
//                    }
//
                
            }
            .tint(Color("icons-secondary"))
        }
    }
    
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedTab: .constant(.contacts))
    }
}
