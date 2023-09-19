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
    
    var chatListViewListeners = [ListenerRegistration]()
    var conversationViewListeners = [ListenerRegistration]()
    
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
        let doc = db.collection("users")
            .document(AuthViewModel.getLoggedInUserId())
            doc.setData(["firstname": firstName,
                         "lastname": lastName,
                         "isactive" : true,
                         "phone": userPhone])
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
    
    //MARK: - Chat Methods
    
    ///This method returns all chat documents for logged in user
    func getAllChats(completion: @escaping ([Chat]) -> Void) {
        
        let db = Firestore.firestore()
        
        let chatsQuery = db.collection("chats")
            .whereField("participantsid", arrayContains: AuthViewModel.getLoggedInUserId())
        
       let listener = chatsQuery.addSnapshotListener { snapshot, error in
            
            if snapshot != nil && error == nil {
                
                var chats = [Chat]()
                
                for doc in snapshot!.documents {
                    
                    let chat = try? doc.data(as: Chat.self)
                    
                    if let chat = chat {
                        chats.append(chat)
                        
                    }
                }
                
                completion(chats)
                
            }
            else {
                print("Error from database.")
            }
            
        }
        //Keeping track of listener to close later
        chatListViewListeners.append(listener)
    }
    
    ///Method returns all messages for given chat
    func getAllMessages(chat: Chat, completion: @escaping ([ChatMessage]) -> Void) {
        
        guard chat.id != nil else {
            completion([ChatMessage]())
            return
        }
        
        let db = Firestore.firestore()
        
        let msgsQuery = db.collection("chats")
            .document(chat.id!)
            .collection("msgs")
            .order(by: "timestamp")
        //Perform query for messages
        let listener = msgsQuery.addSnapshotListener { snapshot, error in
            
            if snapshot != nil && error == nil {
                
                var message = [ChatMessage]()
                
                for doc in snapshot!.documents {
                    
                    let msg = try? doc.data(as: ChatMessage.self)
                    
                    if let msg = msg {
                        message.append(msg)
                    }
                }
                completion(message)
            }
         
            else {
                print("Error in data retrieval")
            }
        }
        //Keep track of listener to close later
        conversationViewListeners.append(listener)
    }
    
    ///Sends text message to database
    func sendMessage(msg: String, chat: Chat) {
        
        guard chat.id != nil else {
            return
        }
 
        let db = Firestore.firestore()
        //Adds message document
        db.collection("chats")
            .document(chat.id!)
            .collection("msgs")
            .addDocument(data: ["imageurl" : "",
                                "msg" : msg,
                                "sendid": AuthViewModel.getLoggedInUserId(),
                                "timestamp" : Date()])
        //Update chat document to reflect msg that was just sent
        db.collection("chats")
            .document(chat.id!)
            .setData(["updated": Date(),
                      "lastmsg": msg],
                        merge: true)
        
    }
    
    ///Send photo message to database
    func sendPhotoMessage(image: UIImage, chat: Chat) {
        
        guard chat.id != nil else {
            return
        }
        
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
        
        //Upload image
        fileRef.putData(imageData!, metadata: nil) { metadata, error in
            
            // Check for errors
            if error == nil && metadata != nil  {
                
                //Get url for image storage
                fileRef.downloadURL { url, error in
                    
                    //Check for errors
                    if url != nil && error == nil {
                        
                        //Store message
                        let db = Firestore.firestore()
                        //Adds message document
                        db.collection("chats")
                            .document(chat.id!)
                            .collection("msgs")
                            .addDocument(data: ["imageurl" : url!.absoluteString,
                                                "msg" : "",
                                                "sendid": AuthViewModel.getLoggedInUserId(),
                                                "timestamp" : Date()])
                        //Update chat document to reflect msg that was just sent
                        db.collection("chats")
                            .document(chat.id!)
                            .setData(["updated": Date(),
                                      "lastmsg": "Image"],
                                        merge: true)
                    }
                }
            }
            
        }
        
    }
    
    func createChat(chat: Chat, completion: @escaping (String) -> Void) {
        //Database reference
        let db = Firestore.firestore()
        
        //Create a new document
       let doc = db.collection("chats").document()
       //Set data for document
        try? doc.setData(from: chat, completion: { error in
            
            //Communicate new document id
            completion(doc.documentID)
        })
        
    }
    
    func detachChatListViewListeners() {
        for listener in chatListViewListeners {
            listener.remove()
        }
    }
    
    func detachConversationViewListeners() {
        for listener in conversationViewListeners {
            listener.remove()
        }
    }
    
    
    //MARK: - Account Methods
    
    func deactivateAccount(completion: @escaping () -> Void) {
        
        //make sure user is logged in
        guard AuthViewModel.isUserLoggedIn() else {
            return
        }
        //Database reference
        let db = Firestore.firestore()
        //Run command
        db.collection("users").document(AuthViewModel.getLoggedInUserId())
            .setData(["isactive" : false, "firstname": "Deleted",
                      "lastname": "User"], merge: true) {
            error in
            
            //Check for errors
            if error == nil {
                completion()
            }
        }
    }
    
}


