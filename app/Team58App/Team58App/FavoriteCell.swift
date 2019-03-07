//
//  FavoriteCell.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/6/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//
// example from https://www.youtube.com/watch?v=NuRghOryegw

import Foundation

import UIKit

class FavoriteCell: UITableViewCell {
    
    var link: ViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
// using star image in our assets folder
        
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        starButton.tintColor = .yellow
        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        
        accessoryView = starButton
    }
    
    @objc private func handleMarkAsFavorite() {
        print("Marked as favorite")
      //  link?.someMethodIWantToCall(cell: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
}

