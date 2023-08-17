//
//  ContactRow.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/14/23.
//

import SwiftUI

struct ContactRow: View {
    
    var user: UserInfo
    
    var body: some View {
        
        HStack(spacing: 24) {
            
            ProfilePicView(user: user)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text("\(user.firstname ?? "") \(user.lastname ?? "")")
                    .font(Font.subHeading)
                
                Text(user.phone ?? "")
                    .font(Font.subheadline)
                    .foregroundColor(Color("text-input"))
            }
            Spacer()
        }
        
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(user: UserInfo())
    }
}
