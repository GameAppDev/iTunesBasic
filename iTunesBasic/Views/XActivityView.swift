//
// XActivityView.swift
// iTunesBasic
//
// Created on 5.02.2022.
// Oguzhan Yalcin
//
//
//


import UIKit

class XActivityView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet var theActivity: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame:  frame)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    private func initSubviews() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        nib.instantiate(withOwner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        theActivity.startAnimating()
        
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
