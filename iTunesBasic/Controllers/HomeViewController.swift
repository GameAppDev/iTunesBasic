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
    
    var isLoadMore:Bool = true
    
    var paginationNumber:Int = 20
    
    var searchedItems:[StoreResponse] = []
    
    var searchedText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        searchTF.delegate = self
        
        itemCollectionView.contentInset = UIEdgeInsets(top: CGFloat(15).dp, left: 0, bottom: CGFloat(15).dp, right: 0)
    }
    
    func setupViews() {
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        navbarView.backgroundColor = UIColor.navbarBGColour
        navbarLabel.textColor = UIColor.navbarTextColour
        navbarLabel.text = "iTunes Store"
        
        searchView.layer.cornerRadius = CGFloat(8)
        searchView.setBorder(width: CGFloat(2), color: UIColor.navbarBGColour)
    }
    
    @IBAction func searchClicked(_ sender: UIButton) {
        searchTF.becomeFirstResponder()
    }
    
    @IBAction func cancelSearchClicked(_ sender: UIButton) {
        searchTF.resignFirstResponder()
        searchTF.text = ""
        searchedItems.removeAll()
        
        itemCollectionView.reloadData()
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
                    self.searchedItems = items
                }
            }
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if var searchText = textField.text {
            searchText = searchText.replace(string: " ",replacement: "+") //URL-encoded text string
            searchedText = searchText
            searchedItems.removeAll()
            
            getSearchedStoreItems(searchText: searchText)
        }
        return true
    }
}
