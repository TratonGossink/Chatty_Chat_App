//
//  SettingsView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 9/15/23.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isSetttingsShowing: Bool
    @Binding var isOnBoarding: Bool
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        
        ZStack {
            //background
            Color("background")
                .ignoresSafeArea()
            VStack {
                //Heading
                
                HStack {
                    Text("Settings")
                        .font(Font.mainHeading)
                    Spacer()
                    
                    Button {
                        //Close Settings
                        isSetttingsShowing = false
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .tint(Color("icons-secondary"))
                    }
                   
                }
                .padding(.top, 20)
                .padding(.horizontal)
                //The form
                Form {
                    
                    Toggle("Dark Mode", isOn: $settingsViewModel.isDarkMode)
                    
                    Button {
                        //Log out action
                        AuthViewModel.logOut()
                        isOnBoarding = true
                        
                    } label: {
                        Text("Log Out")
                    }
                    

                    Button {
                        //Close settings view
        
                    } label: {
                        Text("Delete Account")
                    }
                }
                .background(Color("background"))
            }
            
        }
        .preferredColorScheme(settingsViewModel.isDarkMode ? .dark : .light)
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
        
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(isSetttingsShowing: .constant(false), isOnBoarding: .constant(false))
//    }
//}
