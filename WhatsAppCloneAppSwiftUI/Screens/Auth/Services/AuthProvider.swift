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
    case emailLogInFailed(_ description: String)
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .accountCreationFailed(let description):
            return description
        case .failedToSaveUserInfo(let description):
            return description
        case .emailLogInFailed(let description):
            return description
        }
    }
}
//MARK: - AUTHENTICATION MANAGER
final class AuthManager: AuthProvider {
    
    private init() {
        Task { await autoLogin() }
    }
    
    static let shared: AuthProvider = AuthManager()
    
    var authState = CurrentValueSubject<AuthState, Never>(.pending)
    //MARK:  Auto Login
    func autoLogin() async {
        if Auth.auth().currentUser == nil {
            authState.send(.loggedOut)
        } else {
            fetchCurrentUserInfo()
        }
    }
    //MARK:  Login
    func login(with email: String, and password: String) async throws {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            fetchCurrentUserInfo()
            print("🔐 Successfully Signed In \(authResult.user.email ?? "") ")
        } catch {
            print("🔐 Failed to Sign Into the Account with: \(email) ")
            throw AuthError.emailLogInFailed(error.localizedDescription)

        }
    }
    //MARK:  Create Account
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
    //MARK:  Logout
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
//MARK: - EXTENSION FOR AUTH MANAGER
extension AuthManager {
    //MARK: Save User Info Database
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
    //MARK: Fetch Current User Info
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

extension AuthManager {
    
    static let testAccounts: [String] = [
        "demo3@test.com",
        "demo4@test.com",
        "demo5@test.com",
        "demo6@test.com",
        "demo7@test.com",
        "demo8@test.com",
        "dem10@test.com",
        "demo11@test.com",
        "demo12@test.com",
        "demo13@test.com",
        "demo14@test.com",
        "demo15@test.com",
        "demo16@test.com",
        "demo17@test.com",
        "demo18@test.com",
        "demo19@test.com",
        "demo20@test.com",
        "demo21@test.com",
        "demo22@test.com",
        "demo23@test.com",
        "demo24@test.com",
        "demo25@test.com",
        "demo26@test.com",
        "demo27@test.com",
        "demo28@test.com",
        "demo29@test.com",
        "demo30@test.com",
        "demo31@test.com",
        "demo32@test.com",
        "demo33@test.com",
        "demo34@test.com",
        "demo35@test.com",
        "demo36@test.com",
        "demo37@test.com",
        "demo38@test.com",
        "demo39@test.com",
        "demo40@test.com",
        "demo41@test.com",
        "demo42@test.com",
        "demo43@test.com",
        "demo44@test.com",
        "demo45@test.com",
        "demo46@test.com",
        "demo47@test.com",
        "demo48@test.com",
        "demo49@test.com",
        "demo50@test.com"
        
    ]
}
