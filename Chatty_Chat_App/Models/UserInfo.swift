//
//  UserInfo.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/3/23.
//

import Foundation
import FirebaseFirestoreSwift

struct UserInfo: Codable {
    
    var firstName: String?
    
    var lastName: String?
    
    var phoneNum: String?
     
    var contactPhoto: String?
    
}
