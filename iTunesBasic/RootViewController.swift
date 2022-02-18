//
// RootViewController.swift
// iTunesBasic
//
// Created on 18.02.2022.
// Oguzhan Yalcin
//
//
//


import UIKit

class RootViewController: UIViewController {

    @IBOutlet var activeView: UIView!
    @IBOutlet var topSafeArea: UIView!
    @IBOutlet var bottomSafeArea: UIView!
    
    var activeNC:UINavigationController?
    
    var activity:XActivityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        if let homeNC = appDelegate.theStoryboard.instantiateViewController(withIdentifier: "HomeNC") as? UINavigationController {
            activeNC?.view.removeFromSuperview()
            activeView.addSubview(homeNC.view!)
            
            activeNC = homeNC
        }
    }

    func setupViews() {
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        topSafeArea.backgroundColor = UIColor.navbarBGColour
        bottomSafeArea.backgroundColor = UIColor.clear
    }
    
    func setActivityIndicator(isOn:Bool) {
        if isOn {
            activity = XActivityView(frame: self.view.frame)
            view.addSubview(activity!)
        }
        else {
            if activity != nil && activity?.theActivity != nil {
                activity?.theActivity.stopAnimating()
                activity?.removeFromSuperview()
            }
        }
    }
}
