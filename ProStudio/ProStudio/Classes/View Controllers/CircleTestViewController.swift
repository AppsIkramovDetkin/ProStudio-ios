//
//  CircleTestViewController.swift
//  ProStudio
//
//  Created by Danil Detkin on 08/07/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class CircleTestViewController: UIViewController {
	
	@IBOutlet weak var circleView: PSCircularView!
    
    let shapeLayer = CAShapeLayer()
	
	override func viewDidLoad() {
		super.viewDidLoad()
        circleView.animate(with: 0)
	}
}
