//
//  KeyboardView.swift
//  ProStudio
//
//  Created by Zimma on 01/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class KeyboardView: UIView {
    
    private let buttonCell = "keyboarCell"
    private let backspaceCell = "backspaceCell"
    
    @objc dynamic var numPass = ""
    @objc dynamic var numPassCheck = ""
    
    let keyboardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(keyboardCollectionView)
        
        keyboardCollectionView.dataSource = self
        keyboardCollectionView.delegate = self
        keyboardCollectionView.register(KeyboardCell.self, forCellWithReuseIdentifier: buttonCell)
        keyboardCollectionView.register(BackspaceCell.self, forCellWithReuseIdentifier: backspaceCell)
        
        let views = ["keyboardCollectionView": keyboardCollectionView]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-3-[keyboardCollectionView]-3-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-3-[keyboardCollectionView]-3-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
    }
    
    private func addNum(num: Int) {
        if numPass.count == 4 {
            if numPassCheck.count != 4 {
                numPassCheck.append("\(num)")
            }
        } else {
            numPass.append("\(num)")
        }
    }
    
    private func removeNum() {
        if numPassCheck.count > 0 {
            numPassCheck.removeLast()
        } else {
            if numPass.count > 0 {
                numPass.removeLast()
            }
        }
    }
}

extension KeyboardView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 11 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: backspaceCell, for: indexPath) as! BackspaceCell
            return cell
        } else if indexPath.row == 10 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonCell, for: indexPath) as! KeyboardCell
            cell.numLabel.text = "0"
            return cell
        } else if indexPath.row == 9 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonCell, for: indexPath) as! KeyboardCell
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonCell, for: indexPath) as! KeyboardCell
            cell.numLabel.text = String(indexPath.row + 1)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 3), height: collectionView.frame.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0, 1, 2, 3, 4, 5, 6, 7, 8:
            addNum(num: indexPath.row + 1)
        case 10:
            addNum(num: 0)
        case 11:
            removeNum()
        default:
            break
        }
    }
}
