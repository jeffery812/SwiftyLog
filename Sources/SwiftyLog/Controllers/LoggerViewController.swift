//
//  LoggerViewController.swift
//  SwiftyLog
//
//  Created by Zhihui Tang on 2018-01-10.
//

import UIKit
import MessageUI
import WebKit


private let screenWidth = UIScreen.main.bounds.width
private let screenHeight = UIScreen.main.bounds.height
private let keyWindow = UIApplication.shared.keyWindow

let themeColor: UIColor = UIColor.hex(hex: 0x00B3C4)

class LoggerViewController: UIViewController {

    var delegate: LoggerAction?
    
    var data: String = "" {
        didSet {
            loadWebView()
        }
    }

    var webView: WKWebView = {
        
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=0.6, maximum-scale=0.8, user-scalable=yes';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);";
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentController: WKUserContentController = WKUserContentController()
        let conf = WKWebViewConfiguration()
        conf.userContentController = userContentController
        userContentController.addUserScript(script)
        let view = WKWebView(frame: CGRect.zero, configuration: conf)
        
        /*
        view.scrollView.isScrollEnabled = true               // Make sure our view is interactable
        view.scrollView.bounces = true                    // Things like this should be handled in web code
        view.allowsBackForwardNavigationGestures = false   // Disable swiping to navigate
         */
        return view
    }()
    
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
    
    var btnRemove: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = themeColor
        button.setTitleColor(.white, for: .normal)
        button.roundedCorners(cornerRadius: 5)
        button.setTitle("Remove All", for: .normal)
        button.addTarget(self, action: #selector(btnRemovePressed(_:)), for: .touchUpInside)
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
        
        loadWebView()

    }
    
    private func addSubViews() {
        self.view.backgroundColor = UIColor.white
        
        [webView, btnSend, btnRemove, btnCancel].forEach { (subView: UIView) in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
        let views: [String:UIView] = ["webView": webView, "btnSend": btnSend, "btnRemove": btnRemove, "btnCancel": btnCancel]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[webView]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(16)-[btnSend]-(16)-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(16)-[btnRemove]-(16)-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(16)-[btnCancel]-(16)-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(20)-[webView]-[btnSend(==32)]-[btnRemove(==32)]-[btnCancel(==32)]-(8)-|", options: [], metrics: nil, views: views))
    }
    
    @objc func btnCancelPressed(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func btnSendPressed(_ button: UIButton) {
        sendEmail()
    }
    
    @objc func btnRemovePressed(_ button: UIButton) {
        delegate?.removeAll()
    }
    
    private func sendEmail() {
        guard MFMailComposeViewController.canSendMail() == true else {
            self.showAlert(withTitle: "No email client", message: "Please configure your email client first")
            return
        }

        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        var body = "Host App: \(Bundle.main.bundleIdentifier ?? "")\n"
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            body += "Host App Version: \(version).\(buildNumber)\n"
        }
        if let venderId = UIDevice.current.identifierForVendor {
            body += "identifierForVendor: \(venderId)\n"
        }

        mailComposer.setSubject("Log of \(Bundle.main.bundleIdentifier ?? "")")
        mailComposer.setMessageBody(body, isHTML: false)


        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { (html, error) in
            if let string = html as? String, let data = string.data(using: String.Encoding.utf16) {
                
                mailComposer.addAttachmentData(data, mimeType: "html", fileName: "\(Bundle.main.bundleIdentifier ?? "log").html" )
            } else {
                Logger.shared.e("get data from webview failed")
            }
        }
        /*
        if let data = try? Data(html) {
            mailComposer.addAttachmentData(data, mimeType: "text/txt", fileName: "SwiftyLog.txt")
        }
        */
        self.present(mailComposer, animated: true, completion: nil)
    }
    
    private func loadWebView() {
        webView.loadHTMLString(data, baseURL: nil)
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
