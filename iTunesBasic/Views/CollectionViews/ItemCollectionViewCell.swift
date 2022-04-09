//
// ItemCollectionViewCell.swift
// iTunesBasic
//
// Created on 19.02.2022.
// Oguzhan Yalcin
//
//
//


import UIKit
import Kingfisher

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet var cellView: UIView!
    
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    let identifier:String = "itemCollCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.cornerRadius = CGFloat(8).ws
        cellView.setBorder(width: CGFloat(2).ws, color: UIColor.navbarBGColour)
        
        nameLabel.font = UIFont.dancingScriptSemiBold18
        nameLabel.textColor = UIColor.textColour
        
        priceLabel.font = UIFont.dancingScriptRegular14
        priceLabel.textColor = UIColor.textColour
        
        dateLabel.font = UIFont.dancingScriptRegular14
        dateLabel.textColor = UIColor.textColour
        
        itemImageView.layer.cornerRadius = CGFloat(8).ws
        itemImageView.image = UIImage(named: "DefaultStoreIcon")
    }

    func downloadImage(imageKey:String) {
        if let imageUrl = URL(string: imageKey) {
            DispatchQueue.main.async {
                let resource = ImageResource(downloadURL: imageUrl)
                
                self.itemImageView.kf.setImage(with: resource, placeholder: UIImage(named: "DefaultStoreIcon"), options: [.scaleFactor(UIScreen.main.scale), .cacheOriginalImage]) { result in
                    switch result {
                    case .success(let value):
                        print("Image: \(value.image). Got from: \(value.cacheType)")
                    case .failure(let error):
                        print("Error: \(error)")
                        self.itemImageView.image = UIImage(named: "DefaultStoreIcon")
                    }
                }
            }
        }
    }
}
