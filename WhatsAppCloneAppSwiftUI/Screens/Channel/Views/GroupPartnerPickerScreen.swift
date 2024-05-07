//
//  AddGroupChatPartnersScreen.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 6.05.2024.
//

import SwiftUI

struct GroupPartnerPickerScreen: View {
    
    @State private var searchText = ""
    @ObservedObject var viewModel: ChatPartnerPickerViewModel
    
    var body: some View {
        List {
            
            if viewModel.showSelectedUsers {
                //Text("Users Selected")
                selectedChatPartnerView(users: viewModel.selectedChatPartner) { user in
                    viewModel.handleItemSelection(user)
                }
            }
            
            Section {
                //ForEach(UserItem.placeholders) { item in
                ForEach(viewModel.users) { item in
                    Button {
                        viewModel.handleItemSelection(item)
                    } label: {
                        chatPartnerRowView(item)
                    }
                }
            }
            
            if viewModel.isPaginatable {
                loadMoreUsersView()
            }
        }
        .animation(.easeInOut, value: viewModel.showSelectedUsers)
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search name or number"
        )
        .toolbar {
            titleView()
            trailingNavItem()
        }
    }
    // ChatPartnerRowView deki gorunume extra olarak Button ekliyorum.
    private func chatPartnerRowView(_ user: UserItem) -> some View {
        ChatPartnerRowView(user: user) {
            Spacer()
            let isSelected = viewModel.isUserSelected(user)
            let imageName = isSelected ? "checkmark.circle.fill" : "circle"
            let foregroundStyle = isSelected ? Color.blue : Color(.systemGray4)
            Image(systemName: imageName)
                .foregroundStyle(foregroundStyle)
                .imageScale(.large)
        }
    }
    
    private func loadMoreUsersView() -> some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear) // liste rengini kaldirir.
            .task {
                await viewModel.fetchUsers()
            }
    }
}

extension GroupPartnerPickerScreen {
    @ToolbarContentBuilder
    private func titleView() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            VStack {
                Text("Add Participants")
                    .bold()
                
                let count = viewModel.selectedChatPartner.count
                let maxCount = ChannelContants.maxGroupParticipants
                
                Text("\(count)/\(maxCount)")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
        }
    }
    
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Next") {
                viewModel.navStack.append(.setupGroupChat)
            }
            .bold()
            .disabled(viewModel.disableNextButton) // Butonu disabled eder.
        }
    }
}

#Preview {
    NavigationStack {
        GroupPartnerPickerScreen(viewModel: ChatPartnerPickerViewModel())
    }
}
