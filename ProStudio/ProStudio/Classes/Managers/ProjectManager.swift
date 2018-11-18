//
//  ProjectManager.swift
//  ProStudio
//
//  Created by Hadevs on 18/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import Foundation
import SwiftyJSON
import Firebase

var currentUser: User!

class ProjectManager {
    static let shared = ProjectManager()
    private init() {}
    
    func loadProjects(_ completion: @escaping ItemClosure<[Project]>) {
        let email = currentUser.email ?? ""
        let ref = Database.database().reference().child("projects").child(email.formattedEmail())
        ref.observeSingleEvent(of: .value) { (snapshot) in
            let allDicts = (snapshot.value as? [String: Any]) ?? [:]
            var allProjects: [Project] = []
            allDicts.forEach({ (object) in
                let projectDict = (object.value as? [String: Any]) ?? [:]
                allProjects.append(Project.from(json: JSON(projectDict))!)
            })
            
            completion(allProjects.sorted{$0.startDate < $1.startDate})
        }
    }
}

class Project: Decodable {
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

class ProjectStep: Decodable {
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
