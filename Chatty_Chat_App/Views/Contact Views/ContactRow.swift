//
//  ContactRow.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/14/23.
//

import SwiftUI

struct ContactRow: View {
    
    
    
    
    var body: some View {
        
        AsyncImage(url: URL(string: "")) { phase in
            
            switch phase {
            case AsyncImagePhase.empty:
                //Fetching in process
                ProgressView()
            case AsyncImagePhase.success(let image):
                //Display image fetched
                image
            case AsyncImagePhase.failure(let error):
                //No image available
                Circle()
                    .foregroundColor(.white)
            }
        }
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow()
    }
}
