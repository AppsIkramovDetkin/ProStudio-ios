//
//  ProjectManager.swift
//  ProStudio
//
//  Created by Hadevs on 18/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Firebase

var currentUser: User!

struct PSUser: Searchable {
	var parameter: String {
		return email
	}
	
	var email: String
	
	var id: String {
		return email.formattedEmail()
	}
}

class ProjectManager {
    static let shared = ProjectManager()
    private init() {}
	
	
	func loadAllRequests(_ completion: @escaping ItemClosure<[PSUser]>) {
		Database.database().reference().child("requests").observe(.value) { (snapshot) in
			var ids: [PSUser] = []
			for child in (snapshot.value as? [String: Any] ?? [:]) {
				ids.append(PSUser.init(email: child.key))
			}
			completion(ids)
		}
	}
	
	func loadAllUsers(_ completion: @escaping ItemClosure<[PSUser]>) {
		loadAllProjects { (projects) in
			var s: [PSUser] = []
			for project in projects {
				if !s.contains(where: { (u) -> Bool in
					return u.id == project.client.formattedEmail()
				}) {
					s.append(PSUser.init(email: project.client))
				}
			}
			
			completion(s)
		}
	}
	
	func loadAllProjects(_ completion: @escaping ItemClosure<[Project]>) {
		
		let ref = Database.database().reference().child("projects")
		ref.observeSingleEvent(of: .value) { (snapshot) in
			var allProjects: [Project] = []
			if let emailsBranch = snapshot.value as? [String: Any] {
				for emailObject in emailsBranch {
					
					let allDicts = (emailObject.value as? [String: Any]) ?? [:]
					
					allDicts.forEach({ (object) in
						let projectDict = (object.value as? [String: Any]) ?? [:]
						// crash here, because set of percents invalid from admin panel
						allProjects.append(Project.from(json: JSON(projectDict))!)
					})
					
				}
				completion(allProjects.sorted{$0.startDate < $1.startDate})
			}
		
		}
	}
	
    func loadProjects(_ completion: @escaping ItemClosure<[Project]>) {
        let email = currentUser.email ?? ""
        let ref = Database.database().reference().child("projects").child(email.formattedEmail())
        ref.observeSingleEvent(of: .value) { (snapshot) in
            let allDicts = (snapshot.value as? [String: Any]) ?? [:]
            var allProjects: [Project] = []
            allDicts.forEach({ (object) in
                let projectDict = (object.value as? [String: Any]) ?? [:]
							// crash here, because set of percents invalid from admin panel
                allProjects.append(Project.from(json: JSON(projectDict))!)
            })
            
            completion(allProjects.sorted{$0.startDate < $1.startDate})
        }
    }
    
    func uploadImage(image: UIImage, completion: @escaping ItemClosure<String>) {
        guard let data = image.jpeg(.medium) else {
            completion("")
            return
        }
        let id = ID()
        Storage.storage().reference().child(id).putData(data, metadata: nil) { (metadata, error) in
            completion(id)
        }
    }
    
    var images: [String: UIImage] = [:]
    
    func downloadImage(id: String, completion: @escaping ItemClosure<URL?>) {
        let ref = Storage.storage().reference().child(id)
        ref.downloadURL(completion: { (url, error) in
            completion(url)
        })
    }
    
		func sendMessage(with text: String, userId: String?) {
        let email = userId ?? currentUser.email ?? ""
        let ref = Database.database().reference().child("chats").child(email.formattedEmail()).child("messages").childByAutoId()

        let dict: [String: Any] = [
					"sender": userId != nil ? "admin@admin.admin" : currentUser.email ?? "" ,
            "textMessage": text,
            "time": Date().timeIntervalSince1970
        ]
        
        ref.setValue(dict)
    }
    
		func observeMessages(userId: String?, _ completion: @escaping ItemClosure<[MessageModel]>) {
        let email = userId ?? currentUser.email ?? ""
        let ref = Database.database().reference().child("chats").child(email.formattedEmail()).child("messages")
        ref.observe(.value) { (snapshot) in
            let dicts = snapshot.value as? [String: [String: Any]] ?? [:]
            let messages = dicts.map { MessageModel.from(json: JSON($0.value))! }
            completion(messages.sorted { $0.time ?? 0 < $1.time ?? 0 } )
        }
    }
}

class Project: Decodable, Searchable {
	
	var parameter: String {
		return "\(client), \(name), \(progress)"
	}
	
    var id: String = ""
    var client: String = ""
    var type: String = ""
    var startDate: TimeInterval = 0
    var endDate: TimeInterval = 0
    var name: String = ""
    var isEnded = false
    var progress: Int = 0
    var steps: [ProjectStep] = []
    
    
    var dateTitle: String {
        let format = "dd MMMM"
        return "С \(getStartDate().convertFormateToNormDateString(format: format)) по \(getEndDate().convertFormateToNormDateString(format: format))"
    }
    
    func getStartDate() -> Date {
        return Date(timeIntervalSince1970: startDate)
    }
    
    func getEndDate() -> Date {
        return Date(timeIntervalSince1970: endDate)
    }
    
    var gradientsColor: [UIColor] {
        let typed = ProjectType(rawValue: type)!
        switch typed {
        case .analytics: return [UIColor.init(netHex: 0xdb2149), UIColor.init(netHex: 0x8f1c77)]
        case .appsAndSites: return [UIColor.init(netHex: 0x0067ad), UIColor.init(netHex: 0x3ab1c2)]
        case .seo: return [UIColor.init(netHex: 0x8d1d77), UIColor.init(netHex: 0x0066ad)]
        case .branding: return [UIColor.init(netHex: 0xf7c100), UIColor.init(netHex: 0xdb2249)]
        }
    }
}

class ProjectStep: Codable {
    var name: String = ""
    var isEnded: Bool = false
    var endDate: TimeInterval = 0
    
    func formattedDate() -> String {
        return Date.init(timeIntervalSince1970: endDate).convertFormateToNormDateString(format: "dd.MM.yyyy")
    }
}

extension Decodable {
    static func from(json: JSON) -> Self? {
        do {
            let decoded = try JSONDecoder().decode(Self.self, from: json.rawData())
            return decoded
        } catch {
            print("Deserialize error: \(error.localizedDescription)")
            return nil
        }
    }
}
