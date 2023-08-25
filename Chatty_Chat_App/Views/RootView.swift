//
//  RootView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/28/23.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tabs = .contacts
    
    @State var isOnBoarding = !AuthViewModel.isUserLoggedIn()
    
    @State var isChatShowing = false
    
    var body: some View {
        
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                
                VStack {
                    
                    switch selectedTab {
                        
                    case .chats:
                        ChatsListView(isChatShowing: $isChatShowing)
                    case .contacts:
                        ContactsListView(isChatShowing: $isChatShowing)
                    }
                    
                    Spacer()
                    
                    TabBar(selectedTab: $selectedTab)
                    
                }
            }
            .fullScreenCover(isPresented: $isOnBoarding) {
                
            }
        content: {
            OnBoardingContainerView(isOnboarding: $isOnBoarding)
        }
        .fullScreenCover(isPresented: $isChatShowing){
            
            ConversationView(isChatShowing: $isChatShowing)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
