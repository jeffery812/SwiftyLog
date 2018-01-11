//
//  LoggerViewController.swift
//  SwiftMagic
//
//  Created by Zhihui Tang on 2018-01-10.
//

import UIKit
import MessageUI


private let screenWidth = UIScreen.main.bounds.width
private let screenHeight = UIScreen.main.bounds.height
private let keyWindow = UIApplication.shared.keyWindow

let themeColor: UIColor = UIColor.hex(hex: 0x00B3C4)

class LoggerViewController: UIViewController {

    var textView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    var btnSend: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = themeColor
        button.setTitleColor(.white, for: .normal)
        button.roundedCorners(cornerRadius: 5)
        button.setTitle("Send email", for: .normal)
        button.addTarget(self, action: #selector(btnSendPressed(_:)), for: .touchUpInside)
        
        return button
    }()
    
    var btnCancel: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = themeColor
        button.setTitleColor(.white, for: .normal)
        button.roundedCorners(cornerRadius: 5)
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(btnCancelPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubViews()

    }
    
    private func addSubViews() {
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(textView)
        view.addSubview(btnSend)
        view.addSubview(btnCancel)
        
        [textView, btnSend, btnCancel].forEach { (view: UIView) in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let views: [String:UIView] = ["textView": textView, "btnSend": btnSend, "btnCancel": btnCancel]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[textView]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(16)-[btnSend]-(16)-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(16)-[btnCancel]-(16)-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(20)-[textView]-[btnSend(==32)]-[btnCancel(==32)]-(8)-|", options: [], metrics: nil, views: views))
    }
    
    @objc func btnCancelPressed(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func btnSendPressed(_ button: UIButton) {
        sendEmail()
    }
        
    private func sendEmail() {
        //Check to see the device can send email.
        guard MFMailComposeViewController.canSendMail() == true else {
            self.showAlert(withTitle: "No email client", message: "Please configure your email client first")
            return
        }

        guard let url = Logger.shared.logUrl else { return }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        //Set the subject and message of the email
        mailComposer.setSubject("Have you heard a swift?")
        mailComposer.setMessageBody("This is what they sound like.", isHTML: false)

        if let data = try? Data(contentsOf: url) {
            mailComposer.addAttachmentData(data, mimeType: "text/txt", fileName: "SwiftMagic.txt")
        }
        self.present(mailComposer, animated: true, completion: nil)
    }
}
    
extension LoggerViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        switch result {
            case .cancelled:
                self.showAlert(withTitle: "Cancel", message: "Send email canceled")
                break
            case .sent:
                break
            case .failed:
                self.showAlert(withTitle: "Failed", message: "Send email failed")
                break
            case .saved:
                break
        }
        self.dismiss(animated: true, completion: nil)
    }
}
