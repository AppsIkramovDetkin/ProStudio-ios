//
//  ContactsSegment.swift
//  ProStudio
//
//  Created by Maxim Bezdenezhnykh on 08.07.2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

@IBDesignable
final class ContactsSegment: UIView {
    
    @IBInspectable public var image: UIImage = UIImage() {
        didSet {
            setupViews()
        }
    }
    
    @IBInspectable public var text: String = "Item" {
        didSet {
            setupViews()
        }
    }
    
    @IBInspectable public var font: UIFont = .systemFont(ofSize: 10) {
        didSet {
            setupViews()
        }
    }
    
    @IBInspectable public var selectColor: UIColor = .blue {
        didSet {
            setupViews()
        }
    }
    
    @IBInspectable public var defaultColor: UIColor = .gray {
        didSet {
            setupViews()
        }
    }
    
    @IBInspectable public var isSelectedSegment: Bool = false {
        didSet {
            setupViews()
        }
    }
    
    private var color: UIColor {
        get {
            return isSelectedSegment ? selectColor : defaultColor
        }
    }
    
    private var titleLabel: UILabel = UILabel()
    
    var iconView: UIImageView = UIImageView()
    
    private var bottomLine: UIView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        self.addSubview(iconView)
        self.addSubview(titleLabel)
        self.addSubview(bottomLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
        
        self.addSubview(iconView)
        self.addSubview(titleLabel)
        self.addSubview(bottomLine)
    }
    
    private func setupViews() {
        iconView.image = image
        
        titleLabel.text = text
        titleLabel.font = font
        titleLabel.textColor = isSelectedSegment ? selectColor : defaultColor
        titleLabel.adjustsFontSizeToFitWidth = true
        bottomLine.backgroundColor = isSelectedSegment ? selectColor : .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2,
                                  width: self.frame.width, height: 2)
			
				let iconTopPadding = self.frame.height * 0.33
        let iconLeftPadding = self.frame.width * 0.19
        var topPadding = self.frame.height * 0.27
        let size = self.frame.width * 0.11
				iconView.frame = CGRect(x: iconLeftPadding, y: iconTopPadding, width: size, height: size)
        
        let leftPadding = self.frame.width * 0.36
        topPadding = self.frame.height * 0.43
        let height = self.frame.height * 0.37
        let width = self.frame.width - leftPadding
        titleLabel.frame = CGRect(x: leftPadding, y: topPadding,
                             width: width, height: height)
			
			
    }
    
    
}














