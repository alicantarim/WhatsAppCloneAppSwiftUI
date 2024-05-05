//
//  RootScreen.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 5.05.2024.
//

import SwiftUI

struct RootScreen: View {
    
    @StateObject private var viewModel = RootScreenModel()
    
    var body: some View {
        switch viewModel.authState {
        case .pending:
            ProgressView()
                .controlSize(.large)
            
        case .loggedIn(let loggedInUser):
            MainTabView()
            
        case .loggedOut:
            LoginScreen()
        }
    }
}

#Preview {
    RootScreen()
}
