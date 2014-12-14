//
//  ViewController.swift
//  DanceDeets
//
//  Created by David Xiang on 9/20/14.
//  Copyright (c) 2014 david.xiang. All rights reserved.
//

import UIKit

class FaceBookLoginViewController: UIViewController, FBLoginViewDelegate{
    
    @IBOutlet weak var fbLoginView: FBLoginView!
    
    // MARK: UIViewController
    override func viewDidLoad() {
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = FaceBookLoginViewController.getFacebookPermissions
        view.backgroundColor = UIColor.blackColor()
    }
    
    class var getFacebookPermissions : [String]{
        return ["public_profile", "email", "user_friends","rsvp_event","user_events"]
    }

    // MARK: FBLoginViewDelegate
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
       println("loginViewShowingLoggedInUser")
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        println("loginViewFetchedUserInfo")
        
        AppDelegate.sharedInstance().fbGraphUserObjectId = user.objectID
        
        println("Facebook fetched Graph User Info")
        println("User ID: \(user.objectID)")
        println("User Name: \(user.name)")
        var userEmail = user.objectForKey("email") as String
        println("User Email: \(userEmail)")

        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
        // update token on back
        ServerInterface.sharedInstance.updateFacebookToken()
    }

}

