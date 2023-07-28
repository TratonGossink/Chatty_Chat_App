//
//  ContentView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/28/23.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
