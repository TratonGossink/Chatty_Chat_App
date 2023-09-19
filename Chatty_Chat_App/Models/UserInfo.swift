//
//  UserInfo.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/3/23.
//

import Foundation
import FirebaseFirestoreSwift

struct UserInfo: Codable, Identifiable, Hashable {
    
    @DocumentID var id: String?
    
    var firstname: String?
    
    var lastname: String?
    
    var phone: String?
     
    var photo: String?
    
    var isactive: Bool = true
    
}
