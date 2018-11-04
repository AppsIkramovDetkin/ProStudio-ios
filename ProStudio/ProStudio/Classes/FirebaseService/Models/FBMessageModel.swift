//
//  FBMessageModel.swift
//  ProStudio
//
//  Created by 1488 on 22.09.2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import Foundation

protocol Dictable {
	var message: [AnyHashable: Any] {get}
}

class FBMessage: Dictable {
	var message: [AnyHashable: Any] = [:]
	struct Keys {
		static let senderID = "senderID"
		static let senderName = "senderName"
		static let receiverID = "receiverID"
		static let text = "text"
		static let URLImage = "URLImage"
		static let URLVideo = "URLVideo"
		static let messageType = "messageType"
		static let time = "time"
		
	}
	init?(msg: [String: Any]) {
		guard let id = msg[Keys.senderID] as? Int
			else { return nil }
		message[Keys.senderID] = id
		guard let sendName = msg[Keys.senderName] as? String
			else { return nil }
		message[Keys.senderName]  = sendName
		guard let recid = msg[Keys.receiverID] as? Int
			else { return nil }
		message[Keys.receiverID] = recid
		guard let txt = msg[Keys.text] as? String
			else { return nil }
		message[Keys.text] = txt
		guard let urlImg = msg[Keys.URLImage] as? String
			else { return nil }
		message[Keys.URLImage]  = urlImg
		guard let urlVideo = msg[Keys.URLVideo] as? String
			else { return nil }
		message[Keys.URLVideo] = urlVideo
		guard let temp = msg[Keys.messageType] as? String
			else { return nil }
		if let temp2 = MessageType(type: temp) {
			message[Keys.messageType]  = temp2
		} else {
			return nil
		}
		guard let tm = msg[Keys.time] as? TimeInterval
			else { return nil }
		message[Keys.time]  = tm
	}
}
