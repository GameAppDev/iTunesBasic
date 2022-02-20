//
// TextWithButtonTableViewCell.swift
// iTunesBasic
//
// Created on 20.02.2022.
// Oguzhan Yalcin
//
//
//


import UIKit

class TextWithButtonTableViewCell: UITableViewCell {

    @IBOutlet var urlLabel: UILabel!
    @IBOutlet var urlButton: UIButton!
    
    let identifierTWB:String = "TextWithButtonTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        urlLabel.font = UIFont.dancingScriptRegular14
        urlLabel.textColor = UIColor.textColour
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
