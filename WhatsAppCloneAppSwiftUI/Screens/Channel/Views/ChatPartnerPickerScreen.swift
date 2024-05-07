//
//  ChatPartnerPickerScreen.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 5.05.2024.
//

import SwiftUI

struct ChatPartnerPickerScreen: View {
    
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ChatPartnerPickerViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navStack) {
            List {
                ForEach(ChatPartnerPickerOption.allCases) { item in
                    //Label(item.tittle, systemImage: item.imageName)
                    HeaderItemView(item: item)
                        .onTapGesture {
                            viewModel.navStack.append(.groupPartnerPicker)
                        }
                }
                
                Section {
                    ForEach(0..<12) { _ in
                        ChatPartnerRowView(user: .placeholder)
                    }
                } header: {
                    Text("Contacts on WhatsApp")
                        .textCase(.none)
                        .bold()
                }
            }
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search name or number"
            )
            .navigationTitle("New Chat")
            .navigationDestination(for: ChannelCreationRoute.self) { route in
                destinationView(for: route)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                trailingNavItem()
            }
        }
    }
}

extension ChatPartnerPickerScreen {
    @ViewBuilder
    private func destinationView(for route: ChannelCreationRoute) -> some View {
        switch route {
        case .groupPartnerPicker:
            //Text("ADD GROUP CHAT PARTNER")
            GroupPartnerPickerScreen(viewModel: viewModel)
        case .setupGroupChat:
            //Text("SETUP GROUP CHAT")
            NewGroupSetupScreen(viewModel: viewModel)
        }
    }
}

extension ChatPartnerPickerScreen {
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            cancelButton()
        }
    }
    
    private func cancelButton() -> some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.footnote)
                .bold()
                .foregroundStyle(.gray)
                .padding(8)
                .background(Color(.systemGray5))
                .clipShape(Circle())
        })
    }
}

extension ChatPartnerPickerScreen {
    private struct HeaderItemView: View {
        let item: ChatPartnerPickerOption
        
        var body: some View {
            Button {
                
            } label: {
                buttonBody()
            }
        }
        
        private func buttonBody() -> some View {
            HStack {
                Image(systemName: item.imageName)
                    .font(.footnote)
                    .frame(width: 40, height: 40)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
                
                Text(item.tittle)
            }
        }
    }
}

enum ChatPartnerPickerOption: String, CaseIterable, Identifiable {
    case newGroup = "New Group"
    case newContact = "New Conant"
    case newCommunity = "New Community"
    
    var id: String {
        return rawValue
    }
    
    var tittle: String {
        return rawValue
    }
    
    var imageName: String {
        switch self {
        case .newGroup:
            return "person.2.fill"
        case .newContact:
            return "person.fill.badge.plus"
        case .newCommunity:
            return "person.3.fill"
        }
    }
}

#Preview {
    ChatPartnerPickerScreen()
}
