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
    
    var ws: CGFloat { //Change 320 with your View Width
        return (self / 320) * UIScreen.main.bounds.width
    }
    var hs: CGFloat {
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
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "tr_TR")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSZ"
        if let theDate = dateFormatter.date(from:self) {
            return theDate
        }
        let currentDate = Date()
        return currentDate
    }
    
    func handleCurrencyFormat() -> String {
        var formattedCurrency:String = self
        if self == "TRY" {
            formattedCurrency = "₺"
        }
        else if self == "USD" {
            formattedCurrency = "$"
        }
        else if self == "EURO" {
            formattedCurrency = "€"
        }
        else if self == "STERLIN" {
            formattedCurrency = "£"
        }
        return formattedCurrency
    }
    
    func returnWidth() -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.numberOfLines = 1
        label.text = self
        label.font = UIFont.dancingScriptSemiBold18
        label.sizeToFit()
        return label.frame.width
    }
}

extension Date {
    
    func toString(formatType: String ) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = formatType
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: self)
    }
}
