//
// ImageTableViewCell.swift
// iTunesBasic
//
// Created on 20.02.2022.
// Oguzhan Yalcin
//
//
//


import UIKit
import Kingfisher

class ImageTableViewCell: UITableViewCell {

    @IBOutlet var itemImageView: UIImageView!
    
    let identifier:String = "ImageTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemImageView.image = UIImage(named: "DefaultStoreIcon")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
