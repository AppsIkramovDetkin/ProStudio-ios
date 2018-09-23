//
//  FBAuthentication.swift
//  ProStudio
//
//  Created by 1488 on 01.08.2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import Foundation
import Firebase

class FBAuthentication {
	func login(user: FBUser, failure: @escaping ()->Void,  success: @escaping ()->Void) {
		Auth.auth().signIn(withEmail: user.getEmail(), password: user.getPassword()) { (user, error) in
			if let error = error {
				failure()
			}
			
			if let user = user {
				success()
			}
		}
	}
	
	func register(email: String, password: String, failure: @escaping ()->Void,  success: @escaping ()->Void) {
		Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
			if let error = error {
				failure()
			}
			if let data = authResult {
				success()
			}
		}
	}
}
