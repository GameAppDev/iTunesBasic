//
// TypeCollectionViewCell.swift
// iTunesBasic
//
// Created on 19.02.2022.
// Oguzhan Yalcin
//
//
//


import UIKit

class TypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet var cellView: UIView!
    @IBOutlet var nameLabel: UILabel!
    
    let identifier:String = "typeCollCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.cornerRadius = CGFloat(4).ws
        cellView.setBorder(width: CGFloat(1).ws, color: UIColor.textColour)
        
        nameLabel.font = UIFont.dancingScriptSemiBold18
        nameLabel.textColor = UIColor.textColour
    }
}
