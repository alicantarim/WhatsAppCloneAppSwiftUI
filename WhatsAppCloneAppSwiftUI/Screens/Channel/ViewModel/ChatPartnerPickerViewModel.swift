//
//  ChatPartnerPickerViewModel.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 6.05.2024.
//

import Foundation
import Firebase

enum ChannelCreationRoute {
    case groupPartnerPicker
    case setupGroupChat
}

enum ChannelContants {
    static let maxGroupParticipants = 12
}

@MainActor
final class ChatPartnerPickerViewModel: ObservableObject {
    @Published var navStack = [ChannelCreationRoute]()
    @Published var selectedChatPartner = [UserItem]()
    @Published private(set) var users = [UserItem]()
    private var lastCursor: String?
    
    var showSelectedUsers: Bool {
        return !selectedChatPartner.isEmpty
    }
    
    var disableNextButton: Bool {
        return selectedChatPartner.isEmpty
    }
    
    var isPaginatable: Bool {
        return !users.isEmpty
    }
    
    init() {
        Task {
            await fetchUsers()
        }
    }
    
    //MARK: - Public Mehhods
    //Database' deki kullanicilari getirir.
//    func fetchUsers() async {
//        do {
//            let userNode = try await UserService.paginateUsers(lastCursor: lastCursor, pageSize: 5)
//            self.users.append(contentsOf: userNode.users)
//            self.lastCursor = userNode.currentCursor
//            print("lastCursor: \(lastCursor ?? "") \(users.count)")
//        } catch {
//            print("💿 Failed to fetch users in ChatPartnerPickerViewModel")
//        }
//    }
    
    func fetchUsers() async {
        do {
            let userNode = try await UserService.paginateUsers(lastCursor: lastCursor, pageSize: 5)
            var fetchedUsers = userNode.users
            guard let currenUid = Auth.auth().currentUser?.uid else { return }
            fetchedUsers = fetchedUsers.filter { $0.uid != currenUid }  // Oturum acmis olan kullaniciyi kaldiracak.
            self.users.append(contentsOf: fetchedUsers)
            self.lastCursor = userNode.currentCursor
            print("lastCursor: \(lastCursor ?? "") \(users.count)")
        } catch {
            print("💿 Failed to fetch users in ChatPartnerPickerViewModel")
        }
    }
    
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
