//
//  ContentView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/28/23.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tabs = .contacts
    
    var body: some View {
        
        VStack {
       
            
            TabBar(selectedTab: .constant(.contacts
                                         ))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some
    View {
        RootView()
    }
}
