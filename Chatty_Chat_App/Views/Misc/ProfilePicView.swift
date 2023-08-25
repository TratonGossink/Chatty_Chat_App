//
//  ProfilePicView.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/15/23.
//

import SwiftUI

struct ProfilePicView: View {
    
    var user: UserInfo
    
    var body: some View {

        
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
        
    }
}

struct ProfilePicView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicView(user: UserInfo())
    }
}
