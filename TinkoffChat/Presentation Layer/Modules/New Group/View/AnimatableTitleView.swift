//
//  AnimatableTitleView.swift
//  TinkoffChat
//
//  Created by Kam Lotfull on 30.11.17.
//  Copyright © 2017 Kam Lotfull. All rights reserved.
//

import UIKit

class AnimatableTitleLabel: UILabel {
    private let animationDuration: TimeInterval = 1
    private let onlineScale: CGFloat = 1.1
    private let onlineColor = UIColor.green
    private let offlineColor = UIColor.lightGray
    
    convenience init(isOnline: Bool) {
        self.init()
        self.isOnline = isOnline
        self.textColor = isOnline ? onlineColor : offlineColor
        self.shadowColor = .black
        self.shadowOffset = CGSize(width: 0.5, height: 0.5)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var text: String? {
        didSet {
            sizeToFit()
        }
    }
    
    var isOnline: Bool? = nil {
        didSet {
            guard let oldValue = oldValue else { return }
            if isOnline != oldValue {
                animateStateTo(online: isOnline!)
            }
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let sizeWithoutScaling = super.sizeThatFits(size)
        let sizeScaled = sizeWithoutScaling.applying(CGAffineTransform(scaleX: onlineScale, y: onlineScale))
        return sizeScaled
    }
    
    private func animateStateTo(online: Bool) {
        let transform = online ?
            CGAffineTransform(scaleX: onlineScale, y: onlineScale) :
            .identity
        let color = online ?
            onlineColor :
            offlineColor
        UIView.transition(with: self,
                          duration: animationDuration,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.transform = transform
                            self.textColor = color
        })
    }
}
