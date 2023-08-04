//
//  TextHelper.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/3/23.
//

import Foundation


class TextHelper {
    
    static func sanitizePhoneNumber(_ phone: String) -> String {
        
        return phone
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: " ", with: "")
    }

}
