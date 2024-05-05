//
//  AuthButton.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 4.05.2024.
//

import SwiftUI

struct AuthButton: View {
    
    let title: String
    let onTap: () -> Void
    @Environment(\.isEnabled) private var isEnabled // Button text alanlari dolu degilse enable disable ozelligi icin.
    
    private var backgroundColor: Color {
        return isEnabled ? Color.white : Color.white.opacity(0.3)
    }
    
    private var textColor: Color {
        return isEnabled ? Color.green : Color.white
    }
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack {
                Text(title)
                
                Image(systemName: "arrow.right")
            }
            .font(.headline)
            .foregroundColor(textColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: .green.opacity(0.2), radius: 10)
            .padding(.horizontal, 32)
        }

    }
}

#Preview {
    ZStack {
        Color.teal
        AuthButton(title: "Login") {
            //
        }

    }
}
