//
//  ContactsViewController.swift
//  ProStudio
//
//  Created by Danil Detkin on 03/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
	@IBOutlet weak var segmentedControl: ContactsSegmentedControl!
	@IBOutlet weak var label1: UILabel!
	@IBOutlet weak var label2: UILabel!
	@IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label0: UILabel!
	override func viewDidLoad() {
		super.viewDidLoad()
		NavigationBarDecorator.decorate(self)
		navigationItem.title = "Наши контакты"
		navigationItem.largeTitleDisplayMode = .always
		navigationController?.navigationBar.prefersLargeTitles = true
		segmentedControl.titles = ["Петербург", "Москва"]
		segmentedControl.images = [UIImage(named: "spb")!, UIImage(named: "msc")!]
		segmentedControl.font = PSFont.introBold.with(size: 14.0)
		segmentedControl.defaultColor = PSColor.coolGrey
		decorizeLabel1()
		decorizeLabel2()
		decorizeLabel3()
        label0.setLineHeight(4)
        label0.textAlignment = .center
	}
    let lineHeight: CGFloat = 4.5
	func decorizeLabel1() {
		let attributedString = NSMutableAttributedString(string: "Позвонить\r+7 (812) 645-65-96", attributes: [
			.font: UIFont(name: "Intro-Bold", size: 15)!,
			.foregroundColor: UIColor(white: 0.0, alpha: 1.0)
			])
		attributedString.addAttributes([
			.font: UIFont(name: "Intro-Book", size: 12)!,
			.foregroundColor: UIColor(red: 0.0, green: 127.0 / 255.0, blue: 201.0 / 255.0, alpha: 1.0)
			], range: NSRange(location: 0, length: 9))
		label1.attributedText = attributedString
        label1.setLineHeight(lineHeight)
	}
	
	func decorizeLabel3() {
		let attributedString = NSMutableAttributedString(string: "Проложить маршрут  \rЛенинский пр-т, 151", attributes: [
			.font: UIFont(name: "Intro-Bold", size: 15)!,
			.foregroundColor: UIColor(white: 0.0, alpha: 1.0)
			])
		attributedString.addAttributes([
			.font: UIFont(name: "Intro-Book", size: 12)!,
			.foregroundColor: UIColor(red: 0.0, green: 127.0 / 255.0, blue: 201.0 / 255.0, alpha: 1.0)
			], range: NSRange(location: 0, length: 17))
		label2.attributedText = attributedString
        label2.setLineHeight(lineHeight)
	}
	
	func decorizeLabel2() {
		let attributedString = NSMutableAttributedString(string: "Отправить письмо\rmail@prostudio.ru", attributes: [
			.font: UIFont(name: "Intro-Bold", size: 15)!,
			.foregroundColor: UIColor(white: 0.0, alpha: 1.0)
			])
		attributedString.addAttributes([
			.font: UIFont(name: "Intro-Book", size: 12)!,
			.foregroundColor: UIColor(red: 0.0, green: 127.0 / 255.0, blue: 201.0 / 255.0, alpha: 1.0)
			], range: NSRange(location: 0, length: 16))
		label3.attributedText = attributedString
        label3.setLineHeight(lineHeight)
	}
}

extension UILabel {
    
    func setLineHeight(_ lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(attributedString: self.attributedText!)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
        }
    }
}
