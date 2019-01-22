//
//  PSButton.swift
//  ProStudio
//
//  Created by Danil Detkin on 03/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit
typealias VoidClosure = () -> Void

class PSButton: UIButton {
	var touched: VoidClosure?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		titleLabel?.font = PSFont.introBold.with(size: 15.0)
		setTitleColor(.white, for: .normal)
		backgroundColor = PSColor.cerulean
		layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
		layer.shadowColor = #colorLiteral(red: 0, green: 0.5058823529, blue: 0.8, alpha: 1)
		layer.shadowOpacity = 0.57
		layer.shadowRadius = 7.0
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = frame.height / 2
	}
	
	private func scaleIn() {
		UIView.animate(withDuration: 0.2) {
			self.transform = CGAffineTransform(scaleX: 0.84, y: 0.84)
		}
	}
	
	private func scaleOut() {
		UIView.animate(withDuration: 0.2) {
			self.transform = .identity
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		scaleIn()
		UIImpactFeedbackGenerator(style: .medium).impactOccurred()
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		scaleOut()
		sendActions(for: .touchUpInside)
		touched?()
		UIImpactFeedbackGenerator(style: .light).impactOccurred()
	}
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.scaleOut()
    }
}
