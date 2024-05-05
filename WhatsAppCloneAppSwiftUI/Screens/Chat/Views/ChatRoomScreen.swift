//
//  ChatRoomScreen.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 4.05.2024.
//
import SwiftUI

struct ChatRoomScreen: View {
    var body: some View {
//        ScrollView {
//            LazyVStack {
//                ForEach(0..<12) { _ in
//                    Text("PLACEHOLDER")
//                        .font(.largeTitle)
//                        .bold()
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 200)
//                        .background(Color.gray.opacity(0.1))
//                }
//            }
//        }
        MessageListView()
            .toolbar(.hidden, for: .tabBar) // Bu sayfaya navigationlink ile geldigimizden tabbar da geliyor. Bunu gizledim.
            .toolbar {
                leadingNavItems()
                trailingNavItems()
            }
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .bottom) { // Alt SafeArea ya yaptigim TextInput View ScrollView'dan sonra ekledim.
                TextInputArea()
            }
    }
}

// MARK: - TOOLBAR ITEMS EXTENSION
extension ChatRoomScreen {
     
    @ToolbarContentBuilder
    private func leadingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack {
                Circle().frame(width: 35, height: 35)
                
                Text("Qauser12")
                    .bold()
            }
        }
    }
    
    @ToolbarContentBuilder
    private func trailingNavItems() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button {
                
            } label: {
                Image(systemName: "video")
            }
            
            Button {
                
            } label: {
                Image(systemName: "phone")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChatRoomScreen()
    }
}


