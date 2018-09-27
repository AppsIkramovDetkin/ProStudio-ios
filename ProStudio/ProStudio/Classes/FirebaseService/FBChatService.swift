//
//  FBChatService.swift
//  ProStudio
//
//  Created by 1488 on 22.09.2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import Foundation
import Firebase

class FBChat {
	private var chat_id = ""
	var from: Int
	var to: Int
	var message:  [AnyHashable: Any] = [:]
	private var chat_ref = DatabaseReference()
	
	init(chat_ID: String, from: Int, to: Int, failure: @escaping (Error)->Void) {
		let ref = FBReference.refs.databaseChats.child(chat_ID)
		self.from = from
		self.to = to
		ref.observe(.childAdded, with: getNewMessage) { error
			in
			failure(error)
		}
		chat_ref = ref
	}
	
	func getNewMessage(snapshot: DataSnapshot) {
		guard snapshot.exists()
			else	{	 return }
		guard let dict = snapshot.value as? [String: Any]
			else { return }
		guard let message = FBMessage(msg: dict)
			else { return }
		//return message
	}
	
	func sendText(text: String, failure: @escaping (Error)->Void, success: @escaping ()-> Void) {
		sendMessage(text: text, urlImage: nil, urlVideo:  nil, failure: failure, success: success)
	}
	
	func sendImage(imageURL: URL, failure: @escaping (Error)->Void, success: @escaping ()-> Void) {
		sendURL(resource: .Image, url: imageURL, failure: failure, success: success)
	}
	
	func sendVideo(videoURL: URL, failure: @escaping (Error)->Void, success: @escaping ()-> Void) {
		sendURL(resource: .Video, url: videoURL, failure: failure, success: success)
	}
	
	private func sendURL(resource: MessageType, url: URL, failure: @escaping (Error)-> Void, success: @escaping ()-> Void) {
		let storageRef = FBReference.refs.storageRef.child(ID())
		
		storageRef.putFile(from: url, metadata: nil) { metadata, error in
			if let error = error {
				failure(error)
			}
			if metadata == nil {
				return
			}
			// access to download URL after upload.
			storageRef.downloadURL { (url, error) in
				if let error = error {
					failure(error)
				}
				guard let downloadURL = url else {
					return
				}
				if resource == MessageType.Image{
					self.sendMessage(text: nil, urlImage: downloadURL.description, urlVideo:  nil, failure: failure, success: success)
				}
				else{
					self.sendMessage(text: nil, urlImage: nil, urlVideo:  downloadURL.description, failure: failure, success: success)
				}
			}
		}
	}
	
	func sendMessage(text: String?, urlImage: String?, urlVideo: String? , failure: @escaping (Error)->Void, success: @escaping ()-> Void) {
		let newChat = String(from) + String(to)
		let itemRef = FBReference.refs.databaseChats.child(newChat).childByAutoId()
		message[FBMessage.Keys.text] = ""
		message[FBMessage.Keys.URLImage] = ""
		message[FBMessage.Keys.URLVideo] = ""
		
		message[FBMessage.Keys.senderID] = self.from
		message[FBMessage.Keys.senderName] = "BorisTest"
		message[FBMessage.Keys.receiverID] = self.to
		if let text  = text {
			message[FBMessage.Keys.text] = text
			message[FBMessage.Keys.messageType] = MessageType.Text.rawValue
		}
		if let urlImage = urlImage {
			message[FBMessage.Keys.URLImage] = urlImage
			message[FBMessage.Keys.messageType] = MessageType.Image.rawValue
		}
		if let urlVideo = urlVideo {
			message[FBMessage.Keys.URLVideo] = urlVideo
			message[FBMessage.Keys.messageType] = MessageType.Video.rawValue
		}
		message[FBMessage.Keys.time] = Date().timeIntervalSince1970
		
		itemRef.setValue(message) { (error:Error?, ref:DatabaseReference) in
			if let error = error {
				failure(error)
				return
			}
			success()
		}
		
	}
	
	func ID() -> String {
		let time = String(Int(NSDate().timeIntervalSince1970), radix: 16, uppercase: false)
		let machine = String(arc4random_uniform(900000) + 100000)
		let pid = String(arc4random_uniform(9000) + 1000)
		let counter = String(arc4random_uniform(900000) + 100000)
		return time + machine + pid + counter
	}
	
	deinit {
		chat_ref.removeAllObservers()
	}
}
