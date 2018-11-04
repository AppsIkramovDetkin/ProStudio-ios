//
//  FBUser.swift
//  ProStudio
//
//  Created by 1488 on 01.08.2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import Foundation

struct FBUser{
	private var email: String
	private var password: String
	init(email: String, password: String) {
		self.email = email
		self.password = password
	}
	
	func getEmail() -> String {
		return email
	}
	func getPassword() -> String {
		return password
	}
}
