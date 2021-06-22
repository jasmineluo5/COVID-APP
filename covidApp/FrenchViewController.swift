//
//  FrenchViewController.swift
//  covidApp
//
//  Created by Jane Zha on 6/23/21.
//

import UIKit
import HealthCareLocatorSDK

class FrenchViewController: UIViewController {

    @IBOutlet weak var seg2: UISegmentedControl!
    @IBOutlet weak var wrapperView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let shared = HCLManager.shared

        shared.initialize(apiKey: "1000e4e9d5bedfb7")
        let searchHCPVC = shared.getHCPSearchViewController()
        setupSearchView(searchVC: searchHCPVC)
        shared.setLocale(language: .french)

    }
    
    //For showing the view of the HealthcareSDK
    private func setupSearchView(searchVC: HCLHCPSearchNavigationViewController) {
//        searchVC.modalPresentationStyle = .overFullScreen
//        present(searchVC, animated: true, completion: nil)
        let searchView = searchVC.view!
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchVC.willMove(toParent: self)
        addChild(searchVC)
        wrapperView.addSubview(searchView)
        searchVC.didMove(toParent: self)
        wrapperView.addConstraints([NSLayoutConstraint(item: searchView, attribute: .top, relatedBy: .equal, toItem: wrapperView, attribute: .top, multiplier: 1, constant: 30),
                             NSLayoutConstraint(item: searchView, attribute: .left, relatedBy: .equal, toItem: wrapperView, attribute: .left, multiplier: 1, constant: 0),
                             NSLayoutConstraint(item: searchView, attribute: .bottom, relatedBy: .equal, toItem: wrapperView, attribute: .bottom, multiplier: 1, constant: 0),
                             NSLayoutConstraint(item: searchView, attribute: .right, relatedBy: .equal, toItem: wrapperView, attribute: .right, multiplier: 1, constant: 0)])
    }

    
    

}
