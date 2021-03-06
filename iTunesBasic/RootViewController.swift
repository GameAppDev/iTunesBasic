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
    
    private var activeNC:UINavigationController?
    
    private var activity:XActivityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        DispatchQueue.main.async {
            self.setupViews()
        }
        
        if let homeNC = appDelegate.theStoryboard.instantiateViewController(withIdentifier: "HomeNC") as? UINavigationController {
            activeNC?.view.removeFromSuperview()
            activeView.addSubview(homeNC.view!)
            
            activeNC = homeNC
            
            activeNC?.interactivePopGestureRecognizer?.delegate = self
        }
    }

    private func setupViews() {
        topSafeArea.backgroundColor = UIColor.navbarBGColour
        bottomSafeArea.backgroundColor = UIColor.clear
    }
    
    func setActivityIndicator(isOn:Bool) {
        DispatchQueue.main.async { [self] in
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
}

extension RootViewController: UIGestureRecognizerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        activeNC?.interactivePopGestureRecognizer?.isEnabled = true
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
