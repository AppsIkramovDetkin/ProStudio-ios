//
//  ViewController.swift
//  TablePickerDemo
//
//  Created by Hadevs on 09.08.17.
//  Copyright © 2017 DevLabs. All rights reserved.
//

import UIKit

class TablePickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var data: [String]!
    var didPickedCompletion: (([String]) -> Void)!
    var isMultipleSelectionAllowed = true
    
    private var pickedItems: [String] = []
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if isMultipleSelectionAllowed {
            initDoneButton()
        }
        
        automaticallyAdjustsScrollViewInsets = false
        
        initCancelButton()
    }
    
    private func initDoneButton() {
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonClicked(sender:)))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func initCancelButton() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonClicked(sender:)))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
	@objc func cancelButtonClicked(sender: UIBarButtonItem) {
        smartBack()
    }
    
	@objc func doneButtonClicked(sender: UIBarButtonItem) {
        didPickedCompletion(pickedItems)
        smartBack()
    }
    
    private func initTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        let top = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: bottomLayoutGuide, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        
        view.addConstraints([top, bottom, leading, trailing])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if isMultipleSelectionAllowed {
            if pickedItems.contains(data[indexPath.row]) {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
                pickedItems.remove(at: data.index(of: data[indexPath.row])!)
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                pickedItems.append(data[indexPath.row])
            }
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            pickedItems = [data[indexPath.row]]
            didPickedCompletion(pickedItems)
            smartBack()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

