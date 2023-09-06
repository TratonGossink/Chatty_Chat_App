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
                
                //Check image cache, if it exists
                if let cachedImage = CacheService.getImage(forKey: user.photo!) {
                    
                    //Image in cache
                    cachedImage
                        .resizable()
                        .clipShape(Circle())
                        .scaledToFill()
                        .clipped()
                }
                else {
                    //If not in cache, download
                    
                    
                    //Create URL from user photo url
                    let photoURL = URL(string: user.photo ?? "")
                 //Profile Image
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
                                .onAppear {
                                    //Save image into cache
                                    CacheService.setImage(image: image, forKey: user.photo!)
                                }
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
