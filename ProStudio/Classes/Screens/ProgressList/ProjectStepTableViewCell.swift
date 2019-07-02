//
//  ProjectStepTableViewCell.swift
//  ProStudio
//
//  Created by Danil Detkin on 05/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class ProjectStepTableViewCell: UITableViewCell, NibLoadable {
	
	@IBOutlet weak var leftIconView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var rightLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}

public protocol NibLoadable: class {
	static var nib: UINib { get }
}

public extension NibLoadable {
	static var nib: UINib {
		return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
	}
}

public extension NibLoadable where Self: UIView {
	static func loadFromNib() -> Self {
		guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
			fatalError("The nib \(nib) expected its root view to be of type \(self)")
		}
		return view
	}
}
