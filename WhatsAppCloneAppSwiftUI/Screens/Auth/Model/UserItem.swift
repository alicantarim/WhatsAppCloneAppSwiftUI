//
//  UserItem.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 5.05.2024.
//

import Foundation

struct UserItem: Identifiable, Hashable, Decodable {
    let uid: String
    let username: String
    let email: String
    var bio: String? = nil
    var profileImageUrl: String? = nil
    
    var id: String {
        return uid
    }
    
    var bioUnwrapped: String {
        return bio ?? "Hey there! I am using WhatsApp"
    }
    
    static let placeholder = UserItem(uid: "1", username: "WhatsAppUser", email: "whatsappuser@gmail.com")
    
    static let placeholders: [UserItem] = [
        UserItem(uid: "1", username: "Lavinya", email: "lavinya@gmail.com"),
        UserItem(uid: "2", username: "Kubra", email: "kubra@gmail.com", bio: "Teacher 👩🏼‍🏫"),
        UserItem(uid: "3", username: "Robert", email: "robert@gmail.com", bio: "Passionate about coding"),
        UserItem(uid: "4", username: "Lewis", email: "lewis@gmail.com", bio: "Tech enthusiast"),
        UserItem(uid: "5", username: "Emily", email: "emily@gmail.com", bio: "Hello, I'm Emily"),
        UserItem(uid: "6", username: "John", email: "john@gmail.com", bio: "Dreamer"),
        UserItem(uid: "7", username: "Jack", email: "jack@gmail.com"),
        UserItem(uid: "8", username: "Sophie", email: "sophie@gmail.com", bio: "Music lover"),
        UserItem(uid: "9", username: "David", email: "david@gmail.com", bio: "Travel enthusiast"),
        UserItem(uid: "2", username: "Angelina", email: "angelina@gmail.com", bio: "Lover of nature")
    ]
}

extension UserItem {
    init(dictionary: [String : Any]) {
        self.uid = dictionary[.uid] as? String ?? ""
        self.username = dictionary[.username] as? String ?? ""
        self.email = dictionary[.email] as? String ?? ""
        self.bio = dictionary[.bio] as? String? ?? nil
        self.profileImageUrl = dictionary[.profileImageUrl] as? String? ?? nil
    }
}

extension String {
    static let uid = "uid"
    static let username = "username"
    static let email = "email"
    static let bio = "bio"
    static let profileImageUrl = "profileImageUrl"
}
