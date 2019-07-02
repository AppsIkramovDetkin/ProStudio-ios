//
//  keyboardCell.swift
//  ProStudio
//
//  Created by Zimma on 01/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class KeyboardCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let numLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = PSColors.securityPointOn
        label.font = PSFonts.keyboardLabel
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private func setupCell() {
        addSubview(numLabel)
        numLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
}

