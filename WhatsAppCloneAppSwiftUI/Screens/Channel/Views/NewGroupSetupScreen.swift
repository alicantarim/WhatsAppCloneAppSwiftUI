//
//  NewGroupSetupScreen.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 6.05.2024.
//

import SwiftUI

struct NewGroupSetupScreen: View {
    @State private var channelName = ""
    @ObservedObject var viewModel: ChatPartnerPickerViewModel
    var body: some View {
        List {
            Section {
                channelSteupHeaderView()
            }
            
            Section {
                Text("Disappearing Messages")
                Text("Group Permissions")
            }
            
            Section {
                selectedChatPartnerView(users: viewModel.selectedChatPartner) { user in
                    viewModel.handleItemSelection(user)
                }
            } header: {
                let count = viewModel.selectedChatPartner.count
                let maxCount = ChannelContants.maxGroupParticipants
                Text("Participants: \(count) of \(maxCount)")
                    .bold()
            }
            .listRowBackground(Color.clear)
            
        }
        .navigationTitle("New Group")
        .toolbar {
            trailingNavItem()
        }
    }
    
    private func channelSteupHeaderView() -> some View {
        HStack {
            profileImageView()
            
            TextField("", text: $channelName, prompt: Text("Group Name (optional)"), axis: .vertical)
        }
    }
    
    private func profileImageView() -> some View {
        Button {
            
        } label: {
            ZStack {
                Image(systemName: "camera.fill")
                    .imageScale(.large)
            }
            .frame(width: 60, height: 60)
            .background(Color(.systemGray6))
            .clipShape(Circle())
        }
    }
    
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Create") {
                
            }
            .bold()
            .disabled(viewModel.disableNextButton)
        }
    }
}

#Preview {
    NavigationStack {
        NewGroupSetupScreen(viewModel: ChatPartnerPickerViewModel())
    }
}
