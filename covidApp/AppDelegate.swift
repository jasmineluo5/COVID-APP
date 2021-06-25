//
//  AppDelegate.swift
//  covidApp
//
//  Created by Ben Ann on 6/11/21.
//

import UIKit
import UberCore
import MobileRTC

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //1. Add UIWindow
    var window: UIWindow?
    //for zoom sdk
    //1. Obtain your SDK Key and Secret and paste it here.
    let sdkKey = "HdUp3nfJ480GIRIMK98oE5WZGNqPi3cTSq2e"
    let sdkSecret = "vnzmw2AkK7WkR5GiZroUE1svtEo1jobTFgrY"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupSDK(sdkKey: sdkKey, sdkSecret: sdkSecret)
        return true
    }

    
    //For Uber API callback
    @available(iOS 9, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let handledUberURL = UberAppDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] as Any)

        return handledUberURL
    }
        
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let handledUberURL = UberAppDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)

        return handledUberURL
    }
    
    
    // 2. Create a method that handles the initialization and authentication of the SDK
    func setupSDK(sdkKey: String, sdkSecret: String) {
            let context = MobileRTCSDKInitContext()
            context.domain = "zoom.us"
            context.enableLog = true

            let sdkInitializedSuccessfully = MobileRTC.shared().initialize(context)

            if sdkInitializedSuccessfully == true, let authorizationService = MobileRTC.shared().getAuthService() {
                authorizationService.clientKey = sdkKey
                authorizationService.clientSecret = sdkSecret
                authorizationService.sdkAuth()
            }
        }
    
    func applicationWillTerminate(_ application: UIApplication) {
            // Obtain the MobileRTCAuthService from the Zoom SDK, this service can log in a Zoom user, log out a Zoom user, authorize the Zoom SDK etc.
            if let authorizationService = MobileRTC.shared().getAuthService() {

                // Call logoutRTC() to log the user out.
                authorizationService.logoutRTC()
            }
    }
    
    
}
    
    // MARK: - MobileRTCAuthDelegate
    // Conform AppDelegate to MobileRTCAuthDelegate.
    // MobileRTCAuthDelegate listens to authorization events like SDK authorization, user login, etc.
    extension AppDelegate: MobileRTCAuthDelegate {

        // Result of calling sdkAuth(). MobileRTCAuthError_Success represents a successful authorization.
        func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
            switch returnValue {
            case .success:
                print("SDK successfully initialized.")
            case .keyOrSecretEmpty:
                assertionFailure("SDK Key/Secret was not provided. Replace sdkKey and sdkSecret at the top of this file with your SDK Key/Secret.")
            case .keyOrSecretWrong, .unknown:
                assertionFailure("SDK Key/Secret is not valid.")
            default:
                assertionFailure("SDK Authorization failed with MobileRTCAuthError: \(returnValue).")
            }
        }
        // 1. Listen for the user login result.
        func onMobileRTCLoginReturn(_ returnValue: Int) {
                switch returnValue {
                case 0:
                    print("Successfully logged in")

                    // This alerts the ViewController that the login was successful.
                    NotificationCenter.default.post(name: Notification.Name("userLoggedIn"), object: nil)
                case 1002:
                    print("Password incorrect")
                default:
                    print("Could not log in. Error code: \(returnValue)")
                }
            }

            // 2. Listen for the user logout result. 0 represents a successful log out attempt.
            func onMobileRTCLogoutReturn(_ returnValue: Int) {
                switch returnValue {
                case 0:
                    print("Successfully logged out")
                default:
                    print("Could not log out. Error code: \(returnValue)")
                }
            }
    
}

