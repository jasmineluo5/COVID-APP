//
//  ViewController.swift
//  covidApp
//
//  Created by Ben Ann on 6/11/21.
//

import UIKit
import HealthCareLocatorSDK
import UberRides
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var uberButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let shared = HCLManager.shared
//        let iconsConfig = HCLIconsConfigure(searchIcon: UIImage(named: "iconStar")!,
//                                                  profileIcon: UIImage(named: "iconStar")!,
//                                                  editIcon: UIImage(named: "iconStar")!,
//                                                  crossIcon: UIImage(named: "iconStar")!,
//                                                  backIcon: UIImage(named: "iconStar")!,
//                                                  geolocIcon: UIImage(named: "iconStar")!,
//                                                  markerMinIcon: UIImage(named: "iconStar")!,
//                                                  mapIcon: UIImage(named: "iconStar")!,
//                                                  mapMarker: UIImage(named: "iconStar")!,
//                                                  listIcon: UIImage(named: "iconStar")!,
//                                                  sortIcon: UIImage(named: "iconStar")!,
//                                                  arrowRightIcon: UIImage(named: "iconStar")!,
//                                                  mapGeolocIcon: UIImage(named: "iconStar")!,
//                                                  phoneIcon: UIImage(named: "iconStar")!,
//                                                  faxIcon: UIImage(named: "iconStar")!,
//                                                  websiteIcon: UIImage(named: "iconStar")!,
//                                                  voteUpIcon: UIImage(named: "iconStar")!,
//                                                  voteDownIcon: UIImage(named: "iconStar")!,
//                                                  noResults: UIImage(named: "iconStar")!)
//

               shared.initialize(apiKey: "1000e4e9d5bedfb7")
         let searchHCPVC = shared.getHCPSearchViewController()
        shared.setLocale(language: .english)
        setupSearchView(searchVC: searchHCPVC)
        
        //setting up requesting uber button
        let button = RideRequestButton()
        
        // set a dropoffLocation
        let dropoffLocation = CLLocation(latitude: 37.6213129, longitude: -122.3789554)
        let builder = RideParametersBuilder()
        builder.dropoffLocation = dropoffLocation
        builder.dropoffNickname = "Awesome Airport"
        button.rideParameters = builder.build()

        //center the button
        button.center.x = uberButtonView.center.x

        //put the button in the view
        uberButtonView.addSubview(button)

    }
    
    
    @IBAction func French(_ sender: UIButton) {
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
        wrapperView.addConstraints([NSLayoutConstraint(item: searchView, attribute: .top, relatedBy: .equal, toItem: wrapperView, attribute: .top, multiplier: 1, constant: 120),
                             NSLayoutConstraint(item: searchView, attribute: .left, relatedBy: .equal, toItem: wrapperView, attribute: .left, multiplier: 1, constant: 0),
                             NSLayoutConstraint(item: searchView, attribute: .bottom, relatedBy: .equal, toItem: wrapperView, attribute: .bottom, multiplier: 1, constant: 0),
                             NSLayoutConstraint(item: searchView, attribute: .right, relatedBy: .equal, toItem: wrapperView, attribute: .right, multiplier: 1, constant: 0)])
    }


}

