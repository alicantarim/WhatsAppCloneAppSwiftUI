//
//  AuthProvider.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 5.05.2024.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

enum AuthState {
    case pending, loggedIn(UserItem), loggedOut
}
//MARK: - PROTOCOL FOR AUTH
protocol AuthProvider {
    static var shared: AuthProvider { get }
    var authState: CurrentValueSubject<AuthState, Never> { get }
    func autoLogin() async throws
    func login(with email: String, and password: String) async throws
    func createAccount(for username: String, with email: String, and password: String) async throws
    func logOut() async throws
}
//MARK: - Authentication related custom error management
enum AuthError: Error {
    case accountCreationFailed(_ description: String)
    case failedToSaveUserInfo(_ description: String)
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .accountCreationFailed(let description):
            return description
        case .failedToSaveUserInfo(let description):
            return description
        }
    }
}

final class AuthManager: AuthProvider {
    
    private init() {
        Task { await autoLogin() }
    }
    
    static let shared: AuthProvider = AuthManager()
    
    var authState = CurrentValueSubject<AuthState, Never>(.pending)
    
    func autoLogin() async {
        if Auth.auth().currentUser == nil {
            authState.send(.loggedOut)
        } else {
            fetchCurrentUserInfo()
        }
    }
    
    func login(with email: String, and password: String) async throws {
        
    }
    
    func createAccount(for username: String, with email: String, and password: String) async throws {
        do {
            // Authentication'a user eklenmesi.
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            // Auth da olusturdugumuz kullanicinin uid' si ile Database'de de kullaniciyi olusturuyoruz.
            let uid = authResult.user.uid
            let newUser = UserItem(uid: uid, username: username, email: email)
            try await saveUserInfoDatabase(user: newUser)
            // Oturum acmis olan kullanici bilgisini aliyoruz.
            self.authState.send(.loggedIn(newUser))
        } catch {
            print("🔐 Failed to Create an Account: \(error.localizedDescription)")
            throw AuthError.accountCreationFailed(error.localizedDescription)
        }
    }
    
    func logOut() async throws {
        do {
            try Auth.auth().signOut()
            authState.send(.loggedOut)  //authState uzerinden ekran gecislerini sagladigim icin burada loggedOut gonderiyorum.
            print("🔐 Successfully logged out")
        } catch {
            print("🔐 Failed to logOut current User : \(error.localizedDescription)")

        }
    }
}

extension AuthManager {
    // Kullaniciyi olustururken bu methodu cagirarark bilgilerini database'e de kayit ediyoruz.
    private func saveUserInfoDatabase(user: UserItem) async throws {
        do {
            //let userDictionary = ["uid" : user.uid, "username" : user.username, "email" : user.email]
            let userDictionary: [String : Any] = [.uid : user.uid, .username : user.username, .email : user.email]

            //try await Database.database().reference().child("users").child(user.uid).setValue(userDictionary)
            try await FirebaseConstants.UserRef.child(user.uid).setValue(userDictionary)
        } catch {
            print("🔐 Failed to Save Created user Info to Database: \(error.localizedDescription)")
            throw AuthError.failedToSaveUserInfo(error.localizedDescription)
        }
    }
    
    private func fetchCurrentUserInfo() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        //Database.database().reference().child("users").child(currentUid).observe(.value) { [weak self] snapshot in
        FirebaseConstants.UserRef.child(currentUid).observe(.value) { [weak self] snapshot in

            guard let userDict = snapshot.value as? [String : Any] else { return }
            let loggedInUser = UserItem(dictionary: userDict)
            self?.authState.send(.loggedIn(loggedInUser))
            print("🔐 \(loggedInUser.username) is logged in")
        } withCancel: { error in
            print("Failed to get current user info")
        }

    }
}
