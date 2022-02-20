//
// TextTableViewCell.swift
// iTunesBasic
//
// Created on 20.02.2022.
// Oguzhan Yalcin
//
//
//


import UIKit

enum TextStatus {
    case Title
    case Description
    case Date
    case Kind
    case Artist
    case Price
    case Country
}

class TextTableViewCell: UITableViewCell {

    @IBOutlet var theLabel: UILabel!
    
    let identifierT:String = "TextTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupLabelWith(status:TextStatus) {
        theLabel.textColor = UIColor.textColour
        if status == .Title {
            theLabel.font = UIFont.dancingScriptSemiBold18
            theLabel.textAlignment = .center
        }
        else if status == .Description {
            theLabel.font = UIFont.dancingScriptRegular14
            theLabel.textAlignment = .left
        }
        else if status == .Date {
            theLabel.font = UIFont.dancingScriptRegular14
            theLabel.textAlignment = .right
            theLabel.alpha = CGFloat(0.8)
        }
        else if (status == .Kind) || (status == .Artist) || (status == .Price) || (status == .Country) {
            theLabel.font = UIFont.dancingScriptRegular14
            theLabel.textAlignment = .center
        }
    }
}
