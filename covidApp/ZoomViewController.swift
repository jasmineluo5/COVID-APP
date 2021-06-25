//
//  ZoomViewController.swift
//  covidApp
//
//  Created by Jasmine Luo on 6/22/21.
//

import UIKit
import MobileRTC

class ZoomViewController: UIViewController {

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. The Zoom SDK requires a UINavigationController to update the UI for us. Here we are supplying the SDK with the ViewControllers' navigationController.
           MobileRTC.shared().setMobileRTCRootController(self.navigationController)
        
        /// Notification that is used to start a meeting upon log in success.
           NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: NSNotification.Name(rawValue: "userLoggedIn"), object: nil)
  }
    // MARK: - IBOutlets

    @IBAction func joinAMeetingButtonPressed(_ sender: UIButton) {
        presentJoinMeetingAlert()
    }
    @IBAction func startAnInstantMeetingButtonPressed(_ sender: UIButton) {
        // Obtain the MobileRTCAuthService from the Zoom SDK, and check if the user is logged into Zoom.
         if let authorizationService = MobileRTC.shared().getAuthService(), authorizationService.isLoggedIn() {
             startMeeting()
         } else {
             presentLogInAlert()
         }
    }
    
    // MARK: - Zoom SDK Examples
    /// Puts user into ongoing Zoom meeting using a known meeting number and meeting password.
    ///
    /// Assign a MobileRTCMeetingServiceDelegate to listen to meeting events and join meeting status.
    ///
    /// - Parameters:
    ///   - meetingNumber: The meeting number of the desired meeting.
    ///   - meetingPassword: The meeting password of the desired meeting.
    /// - Precondition:
    ///   - Zoom SDK must be initialized and authorized.
    ///   - MobileRTC.shared().setMobileRTCRootController() has been called.
    func joinMeeting(meetingNumber: String, meetingPassword: String) {
        // Obtain the MobileRTCMeetingService from the Zoom SDK, this service can start meetings, join meetings, leave meetings, etc.
        if let meetingService = MobileRTC.shared().getMeetingService() {

            // Set the ViewContoller to be the MobileRTCMeetingServiceDelegate
            meetingService.delegate = self

            // Create a MobileRTCMeetingJoinParam to provide the MobileRTCMeetingService with the necessary info to join a meeting.
            // In this case, we will only need to provide a meeting number and password.
            let joinMeetingParameters = MobileRTCMeetingJoinParam()
            joinMeetingParameters.meetingNumber = meetingNumber
            joinMeetingParameters.password = meetingPassword

            // Call the joinMeeting function in MobileRTCMeetingService. The Zoom SDK will handle the UI for you, unless told otherwise.
            // If the meeting number and meeting password are valid, the user will be put into the meeting. A waiting room UI will be presented or the meeting UI will be presented.
            meetingService.joinMeeting(with: joinMeetingParameters)
        }
    }

    /// Logs user into their Zoom account using the user's Zoom email and password.
    ///
    /// Assign a MobileRTCAuthDelegate to listen to authorization events including onMobileRTCLoginReturn(_ returnValue: Int).
    ///
    /// - Parameters:
    ///   - email: The user's email address attached to their Zoom account.
    ///   - password: The user's password attached to their Zoom account.
    /// - Precondition:
    ///   - Zoom SDK must be initialized and authorized.
    func logIn(email: String, password: String) {
        // Obtain the MobileRTCAuthService from the Zoom SDK, this service can log in a Zoom user, log out a Zoom user, authorize the Zoom SDK etc.
        if let authorizationService = MobileRTC.shared().getAuthService() {
            // Call the login function in MobileRTCAuthService. This will attempt to log in the user.
//            if  authorizationService.login(withEmail: email, password: password, rememberMe: false){
//                let logInAlertController = UIAlertController(title: "Logged in", message: "You have logged In!", preferredStyle: .alert)
//                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
//                let startMeetingAction = UIAlertAction(title: "Start the Meeting", style: .default,handler: { action in
//                    self.startMeeting()
//               })
//                logInAlertController.addAction(cancelAction)
//                logInAlertController.addAction(startMeetingAction)
//
//                self.present(logInAlertController, animated: true, completion: nil)
//            }
            authorizationService.login(withEmail: email, password: password, rememberMe: false)
            if( authorizationService.isLoggedIn()){
                let logInAlertController = UIAlertController(title: "Logged in", message: "You have logged In!", preferredStyle: .alert)
                                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
                                let startMeetingAction = UIAlertAction(title: "Start the Meeting", style: .default,handler: { action in
                                    self.startMeeting()
                               })
                                
                                logInAlertController.addAction(startMeetingAction)
                logInAlertController.addAction(cancelAction)
                                self.present(logInAlertController, animated: true, completion: nil)
            }
            else{
                let errorAlertController = UIAlertController(title: "Error", message: "Error! Please try again", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
                errorAlertController.addAction(cancelAction)
                self.present(errorAlertController, animated: true, completion: nil)
            }
        }

    }

    /// Creates and starts a Zoom instant meeting. An instant meeting is an unscheduled meeting that begins instantly.
    ///
    /// Assign a MobileRTCMeetingServiceDelegate to listen to meeting events and start meeting status.
    ///
    /// - Precondition:
    ///   - Zoom SDK must be initialized and authorized.
    ///   - MobileRTC.shared().setMobileRTCRootController() has been called.
    ///   - User has logged into Zoom successfully.
    func startMeeting() {
        // Obtain the MobileRTCMeetingService from the Zoom SDK, this service can start meetings, join meetings, leave meetings, etc.
        if let meetingService = MobileRTC.shared().getMeetingService() {
            // Set the ViewContoller to be the MobileRTCMeetingServiceDelegate
            meetingService.delegate = self

            // Create a MobileRTCMeetingStartParam to provide the MobileRTCMeetingService with the necessary info to start an instant meeting.
            // In this case we will use MobileRTCMeetingStartParam4LoginlUser(), since the user has logged into Zoom.
            let startMeetingParameters = MobileRTCMeetingStartParam4LoginlUser()

            // Call the startMeeting function in MobileRTCMeetingService. The Zoom SDK will handle the UI for you, unless told otherwise.
            meetingService.startMeeting(with: startMeetingParameters)
        }
    }

    // MARK: - Convenience Alerts
    /// Creates alert for prompting the user to enter a meeting number and passcode for joining a meeting.
    func presentJoinMeetingAlert() {
        let alertController = UIAlertController(title: "Join meeting", message: "", preferredStyle: .alert)

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Meeting number"
            textField.keyboardType = .phonePad
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Meeting password"
            textField.keyboardType = .asciiCapable
            textField.isSecureTextEntry = true
        }

        let joinMeetingAction = UIAlertAction(title: "Join meeting", style: .default, handler: { alert -> Void in
            let numberTextField = alertController.textFields![0] as UITextField
            let passwordTextField = alertController.textFields![1] as UITextField

            if let meetingNumber = numberTextField.text, let password = passwordTextField.text {
                self.joinMeeting(meetingNumber: meetingNumber, meetingPassword: password)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })

        alertController.addAction(joinMeetingAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

    /// Creates alert for prompting the user to enter thier Zoom credentials for starting a meeting.
    func presentLogInAlert() {
        let alertController = UIAlertController(title: "Log in", message: "", preferredStyle: .alert)

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Email"
            textField.keyboardType = .emailAddress
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Password"
            textField.keyboardType = .asciiCapable
            textField.isSecureTextEntry = true
        }

        let logInAction = UIAlertAction(title: "Log in", style: .default, handler: { alert -> Void in
            let emailTextField = alertController.textFields![0] as UITextField
            let passwordTextField = alertController.textFields![1] as UITextField

            if let email = emailTextField.text, let password = passwordTextField.text {
                self.logIn(email: email, password: password)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })

        alertController.addAction(logInAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Internal
    /// Selector that is used to start a meeting upon log in success.
    @objc func userLoggedIn() {
        startMeeting()
    }
    
 
}

// 1. Extend the ViewController class to adopt and conform to MobileRTCMeetingServiceDelegate. The delegate methods will listen for updates from the SDK about meeting connections and meeting states.
extension ZoomViewController: MobileRTCMeetingServiceDelegate {

    // Is called upon in-meeting errors, join meeting errors, start meeting errors, meeting connection errors, etc.
    func onMeetingError(_ error: MobileRTCMeetError, message: String?) {
        var errorMsg = ""
        switch error {
        case .passwordError:
            errorMsg = "Could not join or start meeting because the meeting password was incorrect."
            print("Could not join or start meeting because the meeting password was incorrect.")
        default:
            errorMsg = "Could not join or start meeting with MobileRTCMeetError: \(error) \(message ?? "")"
            print("Could not join or start meeting with MobileRTCMeetError: \(error) \(message ?? "")")
        }
        let logInAlertController = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        logInAlertController.addAction(cancelAction)
        self.present(logInAlertController, animated: true, completion: nil)

    }

    // Is called when the user joins a meeting.
    func onJoinMeetingConfirmed() {
        print("Join meeting confirmed.")
    }

    // Is called upon meeting state changes.
    func onMeetingStateChange(_ state: MobileRTCMeetingState) {
        print("Current meeting state: \(state)")
    }
}
