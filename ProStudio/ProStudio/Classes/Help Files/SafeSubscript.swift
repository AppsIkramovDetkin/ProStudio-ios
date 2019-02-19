//
//  SafeSubscript.swift
//  ProStudio
//
//  Created by Maxim Bezdenezhnykh on 19/02/2019.
//  Copyright © 2019 Nikita. All rights reserved.
//

import Foundation

extension Collection {
	
	subscript(safe element: Index) -> Element? {
		return indices.contains(element) ? self[element] : nil
	}
}
