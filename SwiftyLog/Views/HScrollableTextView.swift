//
//  HScrollableTextView.swift
//  SwiftMagic
//
//  Created by Zhihui Tang on 2018-01-11.
//

import UIKit

class HScrollableTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        addPanGesture()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addPanGesture()
    }
    
    private func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panView(with:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc func panView(with gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self)
        UIView.animate(withDuration: 0.2) {
            self.bounds.origin.x = self.bounds.origin.x - translation.x <= 0 ? 0 : self.bounds.origin.x - translation.x
        }
        gestureRecognizer.setTranslation(CGPoint.zero, in: self)
    }
}
