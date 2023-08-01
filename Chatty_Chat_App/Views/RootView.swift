//
//  ContentView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/28/23.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tabs = .contacts
    
    @State var isOnBoarding = !AuthViewModel.isUserLoggedIn()
    
    var body: some View {
        
        VStack {
       
            Text("Ello World!")
                .padding()
                .font(Font.mainHeading)
            Spacer()
            
            TabBar(selectedTab: $selectedTab)
        }
        
        .fullScreenCover(isPresented: $isOnBoarding) {
            
        }
    content: {
        OnBoardingContainerView()
        
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
