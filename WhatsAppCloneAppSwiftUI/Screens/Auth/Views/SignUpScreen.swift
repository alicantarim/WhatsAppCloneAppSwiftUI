//
//  SignUpScreen.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 5.05.2024.
//

import SwiftUI

struct SignUpScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var authScreenModel: AuthScreenModel
    
    var body: some View {
        VStack {
            Spacer()
            AuthHeaderView()
                
            AuthTextField(type: .email, text: $authScreenModel.email)
                
//            let userNameInputType = AuthTextField.InputType.custom("Username", "at")
//            AuthTextField(type: userNameInputType, text: .constant(""))
            AuthTextField(type: .custom("Username", "at"), text: $authScreenModel.username)
            
            AuthTextField(type: .password, text: $authScreenModel.password)
                                
            AuthButton(title: "Create an Account") {
                Task { await authScreenModel.handleSignUp() }
            }
            .disabled(authScreenModel.disableSignUpButton)
                
            Spacer()
                
            backButton()
                .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            LinearGradient(colors: [.green, .green.opacity(0.8), .teal], startPoint: .top, endPoint: .bottom)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
    
    private func backButton() -> some View {
        NavigationLink {
            LoginScreen()
        } label: {
            HStack {
                Image(systemName: "sparkles")
                
                (
                    Text("Already created an account ? ")
                    +
                    Text("Log in")
                        .bold()
                )
                
                Image(systemName: "sparkles")
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    SignUpScreen(authScreenModel: AuthScreenModel())
}
