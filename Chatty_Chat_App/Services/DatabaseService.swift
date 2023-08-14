//
//  DatabaseService.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/3/23.
//

import Foundation
import Contacts
import Firebase
import UIKit
import FirebaseStorage
import FirebaseFirestore

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
    
    func setUserProfile(firstName: String, lastName: String, image: UIImage?, completion: @escaping(Bool) -> Void) {
        
        //check if user is logged in  -  TODO: Guard against logged out users
        guard AuthViewModel.isUserLoggedIn() != false else {
            return
        }
        //Firestore reference
        let db = Firestore.firestore()
        //Set profile data
        
        let userPhone = TextHelper.sanitizePhoneNumber(AuthViewModel.getLoggedInUserPhone())
        
        //TODO: After implementing auth, create document with actual users uid
        let doc = db.collection("users").document(AuthViewModel.getLoggedInUserId())
        doc.setData(["firstname": firstName, "lastname": lastName, "phone": userPhone])
        //Check if image is passed through
        if let image = image {
            
            // Create storage reference
            let storageRef = Storage.storage().reference()
            
            // Turn our image into data
            let imageData = image.jpegData(compressionQuality: 0.8)
            
            // Check that we were able to convert it to data
            guard imageData != nil else {
                return
            }
            
            // Specify the file path and name
            let path = "images/\(UUID().uuidString).jpg"
            let fileRef = storageRef.child(path)
            
            let uploadTask = fileRef.putData(imageData!) { meta, error in
                
                if error == nil && meta != nil
                {
                    //Full URL for image
                    fileRef.downloadURL { url, error in
                        
                        if url != nil && error == nil {
           
                    
                            doc.setData(["photo": url!.absoluteString], merge: true) { error in
                        if error == nil {
                            completion(true)
                        }
                    }
                }
                        //Unsuccessful url retrieval
                        else {
                            completion(false)
                        }
            }
        }
                else {
                    completion(false)
                }
            }
            
        }
        else {
            completion(true)
        }
        
        //Upload image data
        
        //set image path to profile
        
    }
    
    func checkUserProfile(completion: @escaping (Bool) -> Void) {
        
        // Check that the user is logged
        guard AuthViewModel.isUserLoggedIn() != false else {
            return
        }
        
        // Create firebase ref
        let db = Firestore.firestore()
        
        db.collection("users").document(AuthViewModel.getLoggedInUserId()).getDocument { snapshot, error in
            
            // TODO: Keep the users profile data
            if snapshot != nil && error == nil {
                
                // Notify that profile exists
                completion(snapshot!.exists)
            }
            else {
                // TODO: Look into using Result type to indicate failure vs profile exists
                completion(false)
            }
            
        }
        
    }
    
}


