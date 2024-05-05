//
//  MessageItem.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 4.05.2024.
//

import Foundation
import SwiftUI

struct MessageItem: Identifiable {
    
    let id = UUID().uuidString
    let text: String
    let type: MessageType
    let direction: MessageDirection     // Message'in sagda mi solda mi gorunecegi
    
    static let sentPlaceholder = MessageItem(text: "Holy Spagetti", type: .text, direction: .sent)
    static let receivedPlaceholder = MessageItem(text: "Holy Dude whats up", type: .text, direction: .received)
    
    var alignment: Alignment {
        return direction == .received ? .leading : .trailing
    }
    
    var horizontalAlignment: HorizontalAlignment {
        return direction == .received ? .leading : .trailing
    }
    
    var backgroundColor: Color {
        return direction == .sent ? .bubbleGreen : .bubbleWhite
    }
    
    static let stubmessages: [MessageItem] = [
        MessageItem(text: "Hi There", type: .text, direction: .sent),
        MessageItem(text: "Check out this Photo", type: .photo, direction: .received),
        MessageItem(text: "Play out this video", type: .video, direction: .sent),
        MessageItem(text: "", type: .audio, direction: .received)
    ]
}

enum MessageType {
    case text, photo, video, audio
}

enum MessageDirection {
    case sent, received
    
    static var random: MessageDirection {
        return [MessageDirection.sent, .received].randomElement() ?? .sent
    }
}
