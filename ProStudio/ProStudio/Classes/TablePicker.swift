//
//  TablePicker.swift
//  TablePickerDemo
//
//  Created by Hadevs on 09.08.17.
//  Copyright © 2017 DevLabs. All rights reserved.
//

import UIKit

class TablePicker: NSObject {
	static func show(fromVC: UIViewController, withData data: [String], isMultiple: Bool?, title: String, andCompletion completion: @escaping ([String]) -> Void) {
        let vc = TablePickerViewController()
        
        vc.data = data
        if let isMultipleSelectionAllowed = isMultiple {
            vc.isMultipleSelectionAllowed = isMultipleSelectionAllowed
        }
        
        vc.didPickedCompletion = completion
        
       let rootVC = fromVC
        vc.title = title
        
        if let nc = rootVC.navigationController {
            nc.pushViewController(vc, animated: true)
        } else {
            rootVC.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        }
    }
}
