//
// DetailViewController.swift
// iTunesBasic
//
// Created on 18.02.2022.
// Oguzhan Yalcin
//
//
//


import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var navbarView: UIView!
    @IBOutlet var navbarLabel: UILabel!
    
    @IBOutlet var detailsTableView: UITableView!
    let identifierI:String = "ImageTableViewCell"
    var imageCell:ImageTableViewCell?
    let identifierT:String = "TextTableViewCell"
    var textCell:TextTableViewCell?
    let identifierTWB:String = "TextWithButtonTableViewCell"
    var buttonTextCell:TextWithButtonTableViewCell?
    
    var searchedSelectedItem:StoreResponse? //from previous
    
    let tableCount:Int = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        DispatchQueue.main.async {
            self.setupViews()
        }
        
        detailsTableView.registerCell(identifier: identifierI)
        detailsTableView.registerCell(identifier: identifierT)
        detailsTableView.registerCell(identifier: identifierTWB)
        detailsTableView.dataSource = self
    }
    
    private func setupViews() {
        navbarView.backgroundColor = UIColor.navbarBGColour
        
        navbarLabel.font = UIFont.dancingScriptBold20
        navbarLabel.textColor = UIColor.navbarTextColour
        navbarLabel.text = "Details"
        
        detailsTableView.contentInset = UIEdgeInsets(top: CGFloat(15).ws, left: 0, bottom: CGFloat(15).ws, right: 0)
    }
    
    @objc func urlClicked() {
        if let collectionUrl = searchedSelectedItem?.collectionViewUrl {
            guard let url = URL(string: collectionUrl) else { return }
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            imageCell = tableView.dequeueReusableCell(withIdentifier: identifierI, for: indexPath) as? ImageTableViewCell
            
            if let imageKey = searchedSelectedItem?.artworkUrl100 {
                imageCell?.downloadImage(imageKey: imageKey)
            }
            
            return imageCell!
        }
        else if indexPath.row == 1 {
            textCell = tableView.dequeueReusableCell(withIdentifier: identifierT, for: indexPath) as? TextTableViewCell
            
            textCell?.setupLabelWith(status: .Title)
            if let title = searchedSelectedItem?.trackName { //if item doesnt have collectionName use trackName
                textCell?.theLabel.text = title
            }
            if let title = searchedSelectedItem?.collectionName {
                textCell?.theLabel.text = title
            }
            
            return textCell!
        }
        else if indexPath.row == 2 {
            textCell = tableView.dequeueReusableCell(withIdentifier: identifierT, for: indexPath) as? TextTableViewCell
            
            textCell?.setupLabelWith(status: .Description)
            if let desc = searchedSelectedItem?.longDescription {
                textCell?.theLabel.text = desc
            }
            
            return textCell!
        }
        else if indexPath.row == 3 {
            textCell = tableView.dequeueReusableCell(withIdentifier: identifierT, for: indexPath) as? TextTableViewCell
            
            textCell?.setupLabelWith(status: .Kind)
            if let kind = searchedSelectedItem?.kind {
                textCell?.theLabel.text = "Kind: \(kind)"
            }
            
            return textCell!
        }
        else if indexPath.row == 4 {
            textCell = tableView.dequeueReusableCell(withIdentifier: identifierT, for: indexPath) as? TextTableViewCell
            
            textCell?.setupLabelWith(status: .Artist)
            if let artist = searchedSelectedItem?.artistName {
                textCell?.theLabel.text = "Artist: \(artist)"
            }
            
            return textCell!
        }
        else if indexPath.row == 5 {
            textCell = tableView.dequeueReusableCell(withIdentifier: identifierT, for: indexPath) as? TextTableViewCell
            
            textCell?.setupLabelWith(status: .Price)
            if let price = searchedSelectedItem?.collectionPrice, let currency = searchedSelectedItem?.currency {
                textCell?.theLabel.text = "\(price) \(currency.handleCurrencyFormat())"
            }
            
            return textCell!
        }
        else if indexPath.row == 6 {
            textCell = tableView.dequeueReusableCell(withIdentifier: identifierT, for: indexPath) as? TextTableViewCell
            
            textCell?.setupLabelWith(status: .Country)
            if let country = searchedSelectedItem?.country {
                textCell?.theLabel.text = "Country: \(country)" //wrong data
            }
            
            return textCell!
        }
        else if indexPath.row == 7 {
            textCell = tableView.dequeueReusableCell(withIdentifier: identifierT, for: indexPath) as? TextTableViewCell
            
            textCell?.setupLabelWith(status: .Date)
            if let publishedDate = searchedSelectedItem?.releaseDate {
                let theDate:Date = publishedDate.toDate()
                let formattedDate:String = theDate.toString(formatType: "dd-MM-yyyy")
                textCell?.theLabel.text = formattedDate
            }
            
            return textCell!
        }
        else if indexPath.row == 8 {
            buttonTextCell = tableView.dequeueReusableCell(withIdentifier: identifierTWB, for: indexPath) as? TextWithButtonTableViewCell
            
            if let url = searchedSelectedItem?.collectionViewUrl {
                buttonTextCell?.urlLabel.textColor = UIColor.selectedTextColour
                buttonTextCell?.urlLabel.text = url
                
                buttonTextCell?.urlButton.addTarget(self, action: #selector(urlClicked), for: .touchUpInside)
            }
            
            return buttonTextCell!
        }
        
        return UITableViewCell()
    }
}
