//
//  SecurityPoints.swift
//  ProStudio
//
//  Created by Zimma on 28/10/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable
class SecurityPoints: UIView {
    
    lazy var firstPoint = PointView()
    lazy var secondPoint = PointView()
    lazy var thirdPoint = PointView()
    lazy var fourthPoint = PointView()
    
    var pointArray =  [PointView]()
    
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupStackVuew()
        addPointsToStackView()
    }
    
    private func setupStackVuew() {
        
        addSubview(stackView)
        stackView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = (stackView.frame.width - (stackView.frame.height * 4)) / 3
    }
    
    private func addPointsToStackView() {
        
        let stackViewHight = stackView.frame.height
        
        firstPoint.heightAnchor.constraint(equalToConstant: stackView.frame.height).isActive = true
        stackView.addArrangedSubview(firstPoint)
        pointArray.append(firstPoint)
        firstPoint.frame.size = CGSize(width: stackViewHight, height: stackViewHight)
        
        secondPoint.heightAnchor.constraint(equalToConstant: stackView.frame.height).isActive = true
        stackView.addArrangedSubview(secondPoint)
        pointArray.append(secondPoint)
        secondPoint.frame.size = CGSize(width: stackViewHight, height: stackViewHight)
        
        thirdPoint.heightAnchor.constraint(equalToConstant: stackView.frame.height).isActive = true
        stackView.addArrangedSubview(thirdPoint)
        pointArray.append(thirdPoint)
        thirdPoint.frame.size = CGSize(width: stackViewHight, height: stackViewHight)
        
        fourthPoint.heightAnchor.constraint(equalToConstant: stackView.frame.height).isActive = true
        stackView.addArrangedSubview(fourthPoint)
        pointArray.append(fourthPoint)
        fourthPoint.frame.size = CGSize(width: stackViewHight, height: stackViewHight)
        
    }
}

