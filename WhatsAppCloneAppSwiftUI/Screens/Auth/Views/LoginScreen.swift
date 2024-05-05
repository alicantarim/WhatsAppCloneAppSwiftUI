//
//  LoginScreen.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 4.05.2024.
//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject private var authScreenModel = AuthScreenModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                AuthHeaderView()
                
                AuthTextField(type: .email, text: $authScreenModel.email)
                AuthTextField(type: .password, text: $authScreenModel.password)
                
                forgotPasswordButton()
                
                AuthButton(title: "Log in now") {
                    //
                }
                .disabled(authScreenModel.disableLoginButton)
                
                Spacer()
                
                signUpButton()
                    .padding(.bottom, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.teal.gradient)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
            .alert(isPresented: $authScreenModel.errorState.showError) { // HATA OLUSTUGUNDA ALERT OLUSTURMA.
                Alert(
                    title: Text(authScreenModel.errorState.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    //MARK: FORGOT PASSWORD BUTTON
    private func forgotPasswordButton() -> some View {
        Button {
            
        } label: {
            Text("Forgot Password ?")
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 32)
                .bold()
                .padding(.vertical)
        }
    }
    //MARK: SIGNUP BUTTON
    private func signUpButton() -> some View {
        NavigationLink {
            SignUpScreen(authScreenModel: authScreenModel)
        } label: {
            HStack {
                Image(systemName: "sparkles")
                
                (
                    Text("Don't have an account ? ")
                    +
                    Text("Create one")
                        .bold()
                )
                
                Image(systemName: "sparkles")
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    LoginScreen()
}
