//
//  DateHelper.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/24/23.
//

import Foundation


class DateHelper {
    
    static func chatTimestampFrom(date: Date?) -> String {
        
        guard date != nil else {
            return ""
        }
        
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        
        return df.string(from: date!)
    }
}
