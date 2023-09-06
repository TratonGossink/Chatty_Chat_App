//
//  RootView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/28/23.
//

import SwiftUI

struct RootView: View {
    
    //For detecting app state changes
    @Environment(\.scenePhase ) var scenePhase
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
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
            .onAppear(perform: {
                if !isOnBoarding {
                    //User has already created account
                    //Load contacts
                    contactsViewModel.getLocalContacts()
                }
            })
        
            .fullScreenCover(isPresented: $isOnBoarding) {
                
            }
        content: {
            OnBoardingContainerView(isOnboarding: $isOnBoarding)
        }
        .fullScreenCover(isPresented: $isChatShowing, onDismiss: nil){
            
            ConversationView(isChatShowing: $isChatShowing)
        }
        .onChange(of: scenePhase) { newPhase in
            
            if newPhase == .active {
                print("Active")
            } else if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .background {
                print("Background")
                chatViewModel.ChatViewCleanup()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
