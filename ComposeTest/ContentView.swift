//
//  ContentView.swift
//  ComposeTest
//
//  Created by Ed Dungan on 10/3/24.
//

import SwiftUI
import MessageUI

struct ContentView: View {
    @State private var isShowingMessageComposer = false
        
    var body: some View {
        VStack {
            Button("Send Message") {
                isShowingMessageComposer = true
                
            }
            Text("SMS: \(MFMessageComposeViewController.canSendText())")
            Text("Attachments: \(MFMessageComposeViewController.canSendAttachments())")
            Text("Subject: \(MFMessageComposeViewController.canSendSubject())")
            
        }
        .sheet(isPresented: $isShowingMessageComposer) {
            MessageComposeView(isShowing: $isShowingMessageComposer, recipients: ["erik.dungan@gmail.com"], body: "Hello, this is a test message!")
        }
    }
}

#Preview {
    ContentView()
}
