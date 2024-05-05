//
//  AddGroupChatPartnersScreen.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 6.05.2024.
//

import SwiftUI

struct AddGroupChatPartnersScreen: View {
    
    @State private var searchText = ""
    @ObservedObject var viewModel: ChatPartnerPickerViewModel
    
    var body: some View {
        List {
            
            if viewModel.showSelectedUsers {
                Text("Users Selected")
            }
            
            Section {
                ForEach([UserItem.placeholder]) { item in
                    Button {
                        viewModel.handleItemSelection(item)
                    } label: {
                        chatPartnerRowView(.placeholder)
                    }
                }
            }
        }
        .animation(.easeInOut, value: viewModel.showSelectedUsers)
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search name or number"
        )
    }
    // ChatPartnerRowView deki gorunume extra olarak Button ekliyorum.
    private func chatPartnerRowView(_ user: UserItem) -> some View {
        ChatPartnerRowView(user: .placeholder) {
            Spacer()
            let isSelected = viewModel.isUserSelected(user)
            let imageName = isSelected ? "checkmark.circle.fill" : "circle"
            let foregroundStyle = isSelected ? Color.blue : Color(.systemGray4)
            Image(systemName: imageName)
                .foregroundStyle(foregroundStyle)
                .imageScale(.large)
        }
    }
}

#Preview {
    NavigationStack {
        AddGroupChatPartnersScreen(viewModel: ChatPartnerPickerViewModel())
    }
}
