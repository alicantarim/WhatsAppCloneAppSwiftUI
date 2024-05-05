//
//  ChatPartnerPickerViewModel.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 6.05.2024.
//

import Foundation

enum ChannelCreationRoute {
    case addGroupChatMembers
    case setupGroupChat
    
}

final class ChatPartnerPickerViewModel: ObservableObject {
    @Published var navStack = [ChannelCreationRoute]()
    @Published var selectedChatPartner = [UserItem]()
    
    var showSelectedUsers: Bool {
        return !selectedChatPartner.isEmpty
    }
    
    //MARK: - Public Mehhods
    func handleItemSelection(_ item: UserItem) {
        if isUserSelected(item) {
            // deselect
            guard let index = selectedChatPartner.firstIndex(where: { $0.uid == item.uid }) else { return }
            selectedChatPartner.remove(at: index)
        } else {
            // select
            selectedChatPartner.append(item)
        }
    }
    
    func isUserSelected(_ user: UserItem) -> Bool {
        let isSelected = selectedChatPartner.contains { $0.uid == user.uid}
        return isSelected
    }
}
