//
//  GroupProfilePicView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 9/12/23.
//

import SwiftUI

struct GroupProfilePicView: View {
    
    var users: [UserInfo]
    
    var body: some View {
        
        let offset = Int(30 / users.count) * -1
        
        ZStack {
            
            ForEach (Array(users.enumerated()), id:\.element) { index, user in
                
                ProfilePicView(user: user)
                    .offset(x: CGFloat(offset * index))
                
            }
        }
        
        //TODO: offset in other direction by half of width
        .offset(x: CGFloat((users.count - 1) * abs(offset) / 2) )
    }
}


