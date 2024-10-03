//
//  MessageComposeView.swift
//  ComposeTest
//
//  Created by Ed Dungan on 10/3/24.
//

import Foundation
import SwiftUI
import MessageUI

// This struct acts as a bridge between UIKit and SwiftUI
struct MessageComposeView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentationMode
    @Binding var isShowing: Bool // To control when to show the message composer
    var recipients: [String] = []
    var body: String = ""
    
    // Coordinator to handle delegate callbacks
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        var parent: MessageComposeView
        
        init(_ parent: MessageComposeView) {
            self.parent = parent
        }
        
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true) {
                self.parent.isShowing = false
            }
            switch result {
            case .sent:
                print("Message sent successfully")
            case .cancelled:
                print("Message composition cancelled")
            case .failed:
                print("Message sending failed")
            @unknown default:
                fatalError()
            }
        }
    }
    
    // Creates the message compose view controller
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let messageVC = MFMessageComposeViewController()
        messageVC.body = body
        messageVC.recipients = recipients
        messageVC.messageComposeDelegate = context.coordinator
        return messageVC
    }

    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
