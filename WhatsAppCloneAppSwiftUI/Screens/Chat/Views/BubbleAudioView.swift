//
//  BubbleAudioView.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 4.05.2024.
//

import SwiftUI

/// We need to Install the following firebase dependencies:
///  FirebaseAuth
///  FirebaseDatabase
///  FirebaseDatabaseSwift
///  FirebaseMessaging
///  FirebaseStorage

struct BubbleAudioView: View {
    
    let item: MessageItem
    @State private var sliderValue: Double = 0
    @State private var sliderRange: ClosedRange<Double> = 0...20
    
    var body: some View {
        VStack(alignment: item.horizontalAlignment, spacing: 2) {
            HStack {
                playButton()
                
                Slider(value: $sliderValue, in: sliderRange)
                    .tint(.gray)
                
                Text("04:00")
                    .foregroundStyle(.gray)
            }
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(5)
            .background(item.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .applyTail(item.direction) // Sohbbette alt kisimdaki centik icin.
        
            timeStampTextView()
        
        }
        .shadow(color: Color(.systemGray3).opacity(0.1), radius: 5, x: 0, y: 20)
        .frame(maxWidth: .infinity, alignment: item.alignment)
        .padding(.leading, item.direction == .received ? 5 : 100)
        .padding(.trailing, item.direction == . received ? 100 : 5)
    }
    
    private func playButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "play.fill")
                .padding(10)
                .background(item.direction == .received ? .green : .white)
                .clipShape(Circle())
                .foregroundStyle(item.direction == .received ? .white : .black)
        }
    }
    
    private func timeStampTextView() -> some View {
        HStack {
            Text("3:05 PM")
                .font(.system(size: 13))
                .foregroundStyle(.gray)
            
            // Okundu Isaretini olusturma
            if item.direction == .sent {
                Image(.seen)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15, height: 15)
                    .foregroundStyle(Color(.systemBlue))
            }
        }
    }
}

#Preview {
    ScrollView {
        BubbleAudioView(item: .sentPlaceholder)
        BubbleAudioView(item: .receivedPlaceholder)
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal)
    .background(Color.gray.opacity(0.4))
    .onAppear {
        // Audio Slider butonunun degistirilmesi.
        let thumbImage = UIImage(systemName: "circle.fill")
        UISlider.appearance().setThumbImage(thumbImage, for: .normal)
    }
}
