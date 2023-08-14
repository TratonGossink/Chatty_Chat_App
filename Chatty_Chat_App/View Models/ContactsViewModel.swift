//
//  ContactsViewModel.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/1/23.
//

import Foundation
import Contacts

class ContactsViewModel: ObservableObject {
    
    @Published var users = [UserInfo]()
    
    private var localContacts = [CNContact]()
    
    func getLocalContacts() {
        
        
        //Created background thread for syncronous method for contacts
        DispatchQueue.init(label: "getcontacts").async {
            
            do{
                let store = CNContactStore()
                
                //CN Key request info
                let keys = [CNContactPhoneNumbersKey,
                            CNContactGivenNameKey,
                            CNContactFamilyNameKey] as [CNKeyDescriptor]
                
                //CN Fetch request info
                let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
                
                //Get user contacts
                try  store.enumerateContacts(with: fetchRequest,usingBlock: { contact, success in
                    
                    self.localContacts.append(contact)
                    
                })
                //Check which local contacts actually are users of the app
                DatabaseService().getPlatformUsers(localContacts: self.localContacts) { platformUsers in
                    
                    //Update the UI in the main thread
                    DispatchQueue.main.async {
                        //Set fetched users to published users property 
                        self.users = platformUsers
                    }
                    
                }
                
            }
            catch {
                print("Unable to retrieve info.")
            }
        }
    }
}
