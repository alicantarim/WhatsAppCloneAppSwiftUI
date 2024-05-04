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
    let direction: MessageDirection     // Message'in sagda mi solda mi gorunecegi
    
    static let sentPlaceholder = MessageItem(text: "Holy Spagetti", direction: .sent)
    static let receivedPlaceholder = MessageItem(text: "Holy Dude whats up", direction: .received)
    
    var alignment: Alignment {
        return direction == .received ? .leading : .trailing
    }
    
    var horizontalAlignment: HorizontalAlignment {
        return direction == .received ? .leading : .trailing
    }
    var backgroundColor: Color {
        return direction == .sent ? .bubbleGreen : .bubbleWhite
    }
}

enum MessageDirection {
    case sent, received
    
    static var random: MessageDirection {
        return [MessageDirection.sent, .received].randomElement() ?? .sent
    }
}
