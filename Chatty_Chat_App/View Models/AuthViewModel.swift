//
//  AuthViewModel.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/31/23.
//

import Foundation
import FirebaseAuth

class AuthViewModel {
    
    static func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    static func getLoggedInUserId() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    static func logOut() {
        try? Auth.auth().signOut()
    }
}
