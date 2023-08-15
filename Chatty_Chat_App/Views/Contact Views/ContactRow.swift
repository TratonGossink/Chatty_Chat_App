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
            
            ZStack {
                
                if user.photo == nil {
                    //Profile img
                    ZStack {
                        Circle()
                            .foregroundColor(.white)
                        Text(user.firstname?.prefix(1) ?? "")
                            .font(Font.mainTitle)
                    }
                }
                else {
                    
                    let photoURL = URL(string: user.photo ?? "")
                    
                    AsyncImage(url: photoURL) { phase in
                        
                        switch phase {
                        case .empty:
                            //Fetching in process
                            ProgressView()
                        case .success(let image):
                            //Display image fetched
                            image
                                .resizable()
                                .clipShape(Circle())
                                .scaledToFill()
                                .clipped()
                        case .failure:
                            
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                Text(user.firstname?.prefix(1) ?? "")
                                    .font(Font.mainTitle)
                            }
                        }
                    }
                }
                //Img border
                Circle()
                    .stroke(Color("create-profile-border"), lineWidth: 2)
            }
            
            .frame(width: 44, height: 44)
            
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
