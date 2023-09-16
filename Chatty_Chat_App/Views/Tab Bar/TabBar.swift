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
    @Binding var isChatShowing: Bool
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
//    @Binding var currentStep: OnboardingStep
    
    var body: some View {
        
        HStack(alignment: .center) {
            Button {
                
                selectedTab = .chats
                
            } label: {
                
                TabBarButton(buttonText: "Chats",
                             imageName: "bubble.left",
                             isActive: selectedTab == .chats)
            }
            .tint(Color("icons-secondary"))
            
            Button {
                
                //Clears selected chat
                chatViewModel.clearSelectedChat()

                //Displays view for new chat creation
              isChatShowing = true
                
            } label: {
                
                VStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    Text("New Chat")
                        .font(Font.smallCaption)
                }
            }
            .tint(Color("icons-primary"))
            
            Button {
                
                selectedTab = .contacts
                
            } label: {
                TabBarButton(buttonText: "Contacts",
                             imageName: "person",
                             isActive: selectedTab == .contacts)
            }
            .tint(Color("icons-secondary"))
        }
        .frame(height: 82)
    }
    
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedTab: .constant(.chats), isChatShowing: .constant(false))
    }
}
