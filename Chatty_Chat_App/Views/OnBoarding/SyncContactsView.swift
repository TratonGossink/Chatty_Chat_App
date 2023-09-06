//
//  SyncContactsView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/31/23.
//

import SwiftUI

struct SyncContactsView: View {

    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @Binding var isOnboarding: Bool
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Image("onboarding-all-set")
     
            Text("All Set!")
                .font(Font.mainHeading)
                .padding(.top, 32)
            Text("Continue to start chatting with your friends.")
                .font(Font.bodyParagraph)
                .padding(.top, 8)
            
            
            Spacer()
            Button {
              //
                isOnboarding = false
            } label: {
                    Text("Continue")
                }
            .buttonStyle(OnboardingButton())
            

                .underline()
                .font(Font.caption)
                .padding(.top, 14)
                .padding(.bottom, 64)
        }
        .onAppear {
            // Gather local contacts
            contactsViewModel.getLocalContacts()
        }
    }
}

struct SyncContactsView_Previews: PreviewProvider {
    static var previews: some View {
        SyncContactsView(isOnboarding: .constant(true))
    }
}
