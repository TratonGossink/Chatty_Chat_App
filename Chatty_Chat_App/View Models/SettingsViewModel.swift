//
//  SettingsViewModel.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 9/15/23.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @AppStorage(Constants.DarkModeKey) var isDarkMode = false
    
    var dbService = DatabaseService()
    
    func deactivateAccount(completion: @escaping () -> Void) {
        
        //Call Database service
        dbService.deactivateAccount {
            
            //Deactivation complete
            completion()
        }
        
    }
    
}
