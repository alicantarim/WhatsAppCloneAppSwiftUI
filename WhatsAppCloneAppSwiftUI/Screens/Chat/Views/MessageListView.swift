//
//  MessageListView.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 4.05.2024.
//

import SwiftUI

// MessageListController da TableView olusturduktan sonra buraya getiriyoruz.
struct MessageListView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MessageListController
    
    func makeUIViewController(context: Context) -> MessageListController {
        let messageListController = MessageListController()
        return messageListController
    }
    
    func updateUIViewController(_ uiViewController: MessageListController, context: Context) { }
    
    
}

#Preview {
    MessageListView()
}
