//
//  FBReference.swift
//  ProStudio
//
//  Created by 1488 on 09.07.2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import Foundation
import Firebase

class FBReference {
	static let refs = FBReference()
	let databaseRoot = Database.database().reference()
	let databaseChats = Database.database().reference().child("chats")
	let storagePhoto = Storage.storage()
	let storageRef = Storage.storage().reference()
}


enum MessageType: String{
	case Text = "Text"
	case Image = "Image"
	case Video = "Video"
	init?(type: String) {
		switch type {
		case "Text":
			self = .Text
		case "Image":
			self = .Image
		case "Video":
			self = .Video
		default:
			return nil
		}
	}
}

