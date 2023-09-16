//
//  ConversationPhotoMessage.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 9/10/23.
//

import SwiftUI

struct ConversationPhotoMessage: View {
    
    var imageUrl: String
    var isFromUser: Bool
    
    var body: some View {
        
            //Check image cache, if it exists
            if let cachedImage = CacheService.getImage(forKey: imageUrl) {
                
                //Image in cache
                cachedImage
                    .resizable()
                    .scaledToFill()
                    .padding(.vertical, 16)
                    .padding(.horizontal, 24)
                    .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
                    .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
            }
            else {
                //Download image
                
                //Create URL from user photo url
                let photoUrl = URL(string: imageUrl)
                //Profile Image
                AsyncImage(url: photoUrl ) { phase in
                    
                    switch phase {
                        
                    case .empty:
                        // Currently fetching
                        ProgressView()
                        
                    case .success(let image):
                        // Display the fetched image
                        image
                            .resizable()
                            .scaledToFill()
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
                            .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                            .onAppear {
                                
                                // Save this image to cache
                                CacheService.setImage(image: image, forKey: imageUrl)
                            }
                        
                    case .failure:
                        // Couldn't fetch profile photo
                        // Display circle with first letter of first name
                        ConversationTextMessage(msg: "Couldn't load image",
                                                isFromUser: isFromUser)
                    }
                }
            }
        }
    }

struct ConversationPhotoMessage_Previews: PreviewProvider {
    static var previews: some View {
        ConversationPhotoMessage(imageUrl: "", isFromUser: true)
    }
}