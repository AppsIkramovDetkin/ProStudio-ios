//
//  BackspaceCell.swift
//  ProStudio
//
//  Created by Zimma on 02/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class BackspaceCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let backSpaceImage: UIImageView = {
        let backSpace = UIImageView()
        backSpace.image = UIImage(named: "backSpace")
        backSpace.contentMode = .scaleAspectFit
        backSpace.translatesAutoresizingMaskIntoConstraints = false
        return backSpace
    }()
    
    private func setupCell() {
        addSubview(backSpaceImage)
        
        let width = bounds.width / 3
        let height = bounds.height / 3
        
        let views = ["backSpaceImage": backSpaceImage]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(width)-[backSpaceImage(\(width))]-\(width)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(height)-[backSpaceImage(\(height))]-\(height / 2)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
    }
    
}
