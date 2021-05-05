//
//  MailView.swift
//  
//
//  Created by Enes Karaosman on 10.12.2020.
//

import SwiftUI
#if canImport(UIKit)
import MessageUI

/**
 Usage
 
 @State private var result: Result<MFMailComposeResult, Error>? = nil
 @State private var isShowingMailView = false
 
 var body: some View {
     Form {
         Button(action: {
             if MFMailComposeViewController.canSendMail() {
                 self.isShowingMailView.toggle()
             } else {
                 print("Can't send emails from this device")
             }
             if result != nil {
                 print("Result: \(String(describing: result))")
             }
         }) {
             HStack {
                 Image(systemName: "envelope")
                 Text("Contact Us")
             }
         }
         // .disabled(!MFMailComposeViewController.canSendMail())
     }
     .sheet(isPresented: $isShowingMailView) {
         MailView(result: $result) { composer in
             composer.setSubject("Secret")
             composer.setToRecipients(["eneskaraosman53@gmail.com"])
         }
     }
 }
 */

// https://stackoverflow.com/questions/56784722/swiftui-send-email
public struct MailView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    public var configure: ((MFMailComposeViewController) -> Void)?
    
    public init(
        result: Binding<Result<MFMailComposeResult, Error>?>,
        configure: ((MFMailComposeViewController) -> Void)? = nil
    ) {
        self._result = result
        self.configure = configure
    }

    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }

        public func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        configure?(vc)
        return vc
    }

    public func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: UIViewControllerRepresentableContext<MailView>) {

    }
}
#endif
