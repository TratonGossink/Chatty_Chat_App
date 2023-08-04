//
//  DatabaseService.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/3/23.
//

import Foundation
import Contacts
import Firebase

class DatabaseService {
    
    func getPlatformUsers(localContacts: [CNContact], completion: @escaping ([UserInfo]) -> Void) {
        
        var platformUsers = [UserInfo]()
        
        var phoneNumberCheck = localContacts.map { contact in
            
            return TextHelper.sanitizePhoneNumber(contact.phoneNumbers.first?.value.stringValue ?? "")
            
        }
        
        guard phoneNumberCheck.count > 0 else {
            
            completion(platformUsers)
            return
        }
        
        let db = Firestore.firestore()
    
        //Perform queries while phone number look up still exists
        while !phoneNumberCheck.isEmpty {
            
        
            let tenContactNumbers = Array(phoneNumberCheck.prefix(10))
            //Removes current 10 to loop through again
            phoneNumberCheck = Array(phoneNumberCheck.dropFirst(10))
            //This method only queries up to 10 items at a time
            let query = db.collection("users").whereField("phone", in: tenContactNumbers)
            
            query.getDocuments { snapshot, error in
                
                if error == nil && snapshot != nil {
                    
                    for doc in snapshot!.documents {
                        
                        if let user = try? doc.data(as: UserInfo.self) {
                            
                            platformUsers.append(user)
                        }
                        
                    }
                    
                    if phoneNumberCheck.isEmpty {
                        completion(platformUsers)
                    }
                    
                }
                
            }
        }
    }
}
