//
// Extensions.swift
// iTunesBasic
//
// Created on 18.02.2022.
// Oguzhan Yalcin
//
//
//


import UIKit
import Foundation

extension UITableView {
    
    func registerCell(identifier:String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        self.tableFooterView = UIView()
        self.rowHeight = UITableView.automaticDimension
        //self.estimatedRowHeight = 100.0
        self.separatorStyle = .none
    }
}

extension UIViewController {
    
    func showAlert(_ mesaj:String, title:String? = "") {
        DispatchQueue.main.async(execute: {
            let app = UIApplication.shared.delegate as! AppDelegate
            let rootVC = app.window!.rootViewController as! RootViewController

            let alertCtrl = UIAlertController(title: title, message: mesaj, preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertCtrl.addAction(action)
            
            rootVC.present(alertCtrl, animated: true, completion: nil)
        })
    }
}

extension CGFloat {
    
    var dp: CGFloat {
        return (self / 320) * UIScreen.main.bounds.width
    }
    var hp: CGFloat {
        return (self / 568) * UIScreen.main.bounds.height
    }
}

extension UIView {
    
    func setBorder(width:CGFloat, color:UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}

extension String {
    
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
}
