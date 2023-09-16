//
//  ContactsViewModel.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/1/23.
//

import Foundation
import Contacts

class ContactsViewModel: ObservableObject {
    
    private var users = [UserInfo]()
    
    private var filterText = ""
    
    @Published var filteredUser = [UserInfo]()
    
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
                        
                        self.filterContacts(filterBy: self.filterText)
                    }
                    
                }
                
            }
            catch {
                print("Unable to retrieve info.")
            }
        }
    }
    
    func filterContacts(filterBy: String) {
        
        self.filterText = filterBy
        
        if filterText == "" {
            
            self.filteredUser = users
            return
        }
        
        self.filteredUser = users.filter({ user in
            
            user.firstname?.lowercased().contains(filterText) ?? false ||
            user.lastname?.lowercased().contains(filterText) ?? false ||
            user.phone?.contains(filterText) ?? false
            
        })
    }
    
    ///Given list of user ids, returns a list of user object that have the same user ids
    func getParticipant(ids: [String]) -> [UserInfo] {
        
        //Filter out user list only for participants based on ids passed in
       let actualUsers = users.filter { user in
            
            if user.id == nil {
                return false
            }
           else {
               return ids.contains(user.id!)
           }
        }
        return actualUsers
        
    }
    
}
