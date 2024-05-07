//
//  RootScreenModel.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 5.05.2024.
//

import Foundation
import Combine

final class RootScreenModel: ObservableObject {
    
    @Published private(set) var authState = AuthState.pending
    private var cancellable: AnyCancellable?
    
    init () {
        cancellable = AuthManager.shared.authState.receive(on: DispatchQueue.main)
            .sink { [weak self] latestAuthState in
                self?.authState = latestAuthState
            }
        
        // Demo user'lari olusturmak icin init methodunda cagiriyoruz.
        // Bunu sadece kullanicilari hizlica olusturmak icin bir kere kullandim.
//        AuthManager.testAccounts.forEach { email in
//            registerTestAccounts(with: email)
//        }
    }
    
    // Demo kullanicilari Kayit etmek icin olusturdugum method.
//    private func registerTestAccounts(with email: String) {
//        Task {
//            let username = email.replacingOccurrences(of: "@test.com", with: "")
//            try? await AuthManager.shared.createAccount(for: username, with: email, and: "123456")
//        }
//    }
}
