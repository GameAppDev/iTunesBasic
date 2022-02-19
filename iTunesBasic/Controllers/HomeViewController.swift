//
// HomeViewController.swift
// iTunesBasic
//
// Created on 18.02.2022.
// Oguzhan Yalcin
//
//
//


import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var navbarView: UIView!
    @IBOutlet var navbarLabel: UILabel!
    
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTF: UITextField!
    
    @IBOutlet var itemCollectionView: UICollectionView!
    var itemCell:ItemCollectionViewCell?
    
    @IBOutlet var typeCollectionView: UICollectionView!
    var typeCell:TypeCollectionViewCell?
    
    var isLoadMore:Bool = true //load more
    
    var paginationNumber:Int = 20 //load more
    
    var searchedText:String = "" //to understand searched text when load more
    var selectedIndex:Int = 0 //to understand which type coll cell is active when load more
    
    var searchedItems:[StoreResponse] = [] //for item coll array
    var allItems:[StoreResponse] = [] //when select type all
    
    //wrapperType are just track, collection, artistFor. Mostly track so i used kind to filter items
    let kinds:[String] = ["all", "podcast", "music-video", "book", "album", "coached-audio", "feature-movie", "interactive- booklet", "pdf podcast", "podcast-episode", "software-package", "song", "tv-episode", "artistFor"]
    var types:[Types] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setTypesData()
        
        searchTF.delegate = self
        
        itemCollectionView.contentInset = UIEdgeInsets(top: CGFloat(15).ws, left: CGFloat(10).ws, bottom: CGFloat(15).ws, right: CGFloat(10).ws)
        itemCollectionView.keyboardDismissMode = .onDrag
        itemCollectionView.register(UINib(nibName:"ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "itemCollCell")
        itemCollectionView.dataSource = self
        itemCollectionView.delegate = self
        
        typeCollectionView.contentInset = UIEdgeInsets(top: 0, left: CGFloat(15).ws, bottom: 0, right: CGFloat(15).ws)
        typeCollectionView.register(UINib(nibName:"TypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "typeCollCell")
        typeCollectionView.dataSource = self
        typeCollectionView.delegate = self
    }
    
    func setupViews() {
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        navbarView.backgroundColor = UIColor.navbarBGColour
        navbarLabel.textColor = UIColor.navbarTextColour
        navbarLabel.text = "iTunes Store"
        
        searchView.layer.cornerRadius = CGFloat(8).ws
        searchView.setBorder(width: CGFloat(2).ws, color: UIColor.navbarBGColour)
        
        searchTF.font = UIFont.dancingScriptRegular14
        searchTF.textColor = UIColor.textColour
    }
    
    func setTypesData() {
        for (_, item) in kinds.enumerated() {
            let newType = Types(name: item, isSelected: false)
            types.append(newType)
        }
    }
    
    func filterSearchedItems(type:String) {
        if type == "all" {
            searchedItems = allItems
        }
        else {
            var newItems:[StoreResponse] = []
            for (_, item) in allItems.enumerated() {
                if item.kind == type {
                    newItems.append(item)
                }
            }
            searchedItems = newItems
        }
        itemCollectionView.reloadData()
    }
    
    @IBAction func searchClicked(_ sender: UIButton) {
        searchTF.becomeFirstResponder()
    }
    
    @IBAction func cancelSearchClicked(_ sender: UIButton) {
        searchTF.resignFirstResponder()
        searchTF.text = ""
        searchedText = ""
        allItems.removeAll()
        searchedItems.removeAll()
        
        itemCollectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == itemCollectionView {
            return searchedItems.count
        }
        else if collectionView == typeCollectionView {
            return types.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == itemCollectionView {
            return CGFloat(10).ws
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == itemCollectionView {
            itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCollCell", for: indexPath) as? ItemCollectionViewCell
            
            let item = searchedItems[indexPath.row]
            
            if let imageKey = item.artworkUrl100 {
                itemCell?.downloadImage(imageKey: imageKey)
            }
            
            if let name = item.collectionName {
                itemCell?.nameLabel.text = name
            }
            
            if let price = item.collectionPrice, let currency = searchedItems[indexPath.row].currency {
                itemCell?.priceLabel.text = "\(price) \(currency.handleCurrencyFormat())"
            }
            
            if let publishedDate = item.releaseDate {
                let theDate:Date = publishedDate.toDate()
                let formattedDate:String = theDate.toString(formatType: "dd-MM-yyyy")
                itemCell?.dateLabel.text = formattedDate
            }
            
            return itemCell!
        }
        
        else if collectionView == typeCollectionView {
            typeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCollCell", for: indexPath) as? TypeCollectionViewCell
            
            let type = types[indexPath.row]
            
            typeCell?.nameLabel.text = type.name
            
            if type.isSelected {
                typeCell?.cellView.setBorder(width: CGFloat(1).ws, color: UIColor.selectedTextColour)
                typeCell?.nameLabel.textColor = UIColor.selectedTextColour
            }
            else {
                typeCell?.cellView.setBorder(width: CGFloat(1).ws, color: UIColor.textColour)
                typeCell?.nameLabel.textColor = UIColor.textColour
            }
            
            return typeCell!
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == itemCollectionView {
            return CGSize(width: CGFloat(150).ws, height: CGFloat(227).ws)
        }
        else if collectionView == typeCollectionView {
            var cellWidth:CGFloat = 0
            cellWidth = types[indexPath.row].name.returnWidth() + CGFloat(20).ws // add also cell margins
            return CGSize(width: cellWidth, height: CGFloat(30).ws)
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !isLoadMore && searchedItems.count == indexPath.row + 1 && paginationNumber != 20 && (selectedIndex == 0) {
            getSearchedStoreItems(searchText: searchedText)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == itemCollectionView {
            
        }
        else if collectionView == typeCollectionView {
            setSelectedTypeStatus(selectedIndex: indexPath.row)
        }
    }
    
    func setSelectedTypeStatus(selectedIndex:Int) {
        if let index = types.firstIndex(where: {$0.isSelected == true}) {
            types[index].isSelected = false
        }
        self.selectedIndex = selectedIndex
        types[selectedIndex].isSelected = true
        filterSearchedItems(type: types[selectedIndex].name)
        typeCollectionView.reloadData()
    }
}

extension HomeViewController {
    
    func getSearchedStoreItems(searchText:String) {
        appDelegate.rootVC.setActivityIndicator(isOn: true)
        isLoadMore = true
        ServiceManager.connected.getStoreItems(term: searchText, country: "TR", limit: paginationNumber) { response, isOK in
            self.isLoadMore = false
            appDelegate.rootVC.setActivityIndicator(isOn: false)
            if isOK {
                if let items = response {
                    self.paginationNumber += 20
                    self.allItems = items
                    self.searchedItems = items
                    self.setSelectedTypeStatus(selectedIndex: 0)
                }
            }
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if var searchText = textField.text {
            textField.resignFirstResponder()
            searchText = searchText.replace(string: " ",replacement: "+") //URL-encoded text string
            searchedText = searchText
            allItems.removeAll()
            searchedItems.removeAll()
            selectedIndex = 0
            paginationNumber = 20
            
            getSearchedStoreItems(searchText: searchText)
        }
        return true
    }
}
