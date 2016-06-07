//
//  LogonViewController.swift
//  obento
//
//  Created by masa on 2016/04/20.
//  Copyright © 2016年 com.tryworks-design. All rights reserved.
//

import UIKit
import LocalAuthentication

class LogonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. Create a authentication context
        let authenticationContext = LAContext()
        var error:NSError?
        
        // 2. Check if the device has a fingerprint sensor
        // If not, show the user an alert view and bail out!
        guard authenticationContext.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) else {
            
            showAlertViewIfNoBiometricSensorHasBeenDetected()
            return
            
        }
        
        // 3. Check the fingerprint
        authenticationContext.evaluatePolicy(
            .DeviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Only awesome people are allowed",
            reply: { [unowned self] (success, error) -> Void in
                
            if( success ) {
                
                // Fingerprint recognized
                // Go to view controller
                self.navigateToAuthenticatedViewController()
                
            }else {
                
                // Check if there is an error
                if let error = error {
                    
                    let message = self.errorMessageForLAErrorCode(error.code)
                    self.showAlertViewAfterEvaluatingPolicyWithMessage(message)
                    
                }
                
            }
            
        })
        // Do any additional setup after loading the view.
    }
    func showAlertViewAfterEvaluatingPolicyWithMessage( message:String ){
        
        showAlertWithTitle("Error", message: message)
        
    }
    func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        
        showAlertWithTitle("Error", message: "This device does not have a TouchID sensor.")
        
    }
    func showAlertWithTitle( title:String, message:String ) {
     
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertVC.addAction(okAction)
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
        
            self.presentViewController(alertVC, animated: true, completion: nil)
            
        }
        
    }
func errorMessageForLAErrorCode( errorCode:Int ) -> String{
    
    var message = ""
    
    switch errorCode {
        
    case LAError.AppCancel.rawValue:
        message = "Authentication was cancelled by application"
        
    case LAError.AuthenticationFailed.rawValue:
        message = "The user failed to provide valid credentials"
        
    case LAError.InvalidContext.rawValue:
        message = "The context is invalid"
        
    case LAError.PasscodeNotSet.rawValue:
        message = "Passcode is not set on the device"
        
    case LAError.SystemCancel.rawValue:
        message = "Authentication was cancelled by the system"
        
    case LAError.TouchIDLockout.rawValue:
        message = "Too many failed attempts."
        
    case LAError.TouchIDNotAvailable.rawValue:
        message = "TouchID is not available on the device"
        
    case LAError.UserCancel.rawValue:
        message = "The user did cancel"
        
    case LAError.UserFallback.rawValue:
        message = "The user chose to use the fallback"
        
    default:
        message = "Did not find error code on LAError object"
        
    }
    
    return message
    
}
    /**
        This method will push the authenticated view controller onto the UINavigationController stack
    */
    func navigateToAuthenticatedViewController(){
        
        if let loggedInVC = storyboard?.instantiateViewControllerWithIdentifier("ViewController") {
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                
                self.navigationController?.pushViewController(loggedInVC, animated: true)
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
