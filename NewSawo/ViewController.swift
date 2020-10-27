//
//  ViewController.swift
//  NewSawo
//
//  Created by Rhytthm Mahajan on 06/10/20.
//  Copyright © 2020 SAWO. All rights reserved.
//

import UIKit
import apiSawoFrame

class ViewController: UIViewController {
    let VC = apiSawoFrame.LoginViewController()
    var PayloadApi = ""

    @IBAction func Login(_ sender: Any) {
    present(VC, animated: true, completion: nil)
    let apiKey = ["apikey": "<ADD-YOUR-KEY-HERE>"]
    let identifierType = ["identifier": "<ADD-IDENTIFIER-HERE"]
    NotificationCenter.default.post(name: Notification.Name("ProductKey"), object: nil,userInfo: apiKey)
    NotificationCenter.default.post(name: Notification.Name("IdentifierType"), object:nil, userInfo: identifierType)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    NotificationCenter.default.addObserver(self, selector: #selector(LoginIsApproved(_:)), name: Notification.Name("LoginApproved"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(loginCONTENTapi(_:)), name: Notification.Name("PayloadOfUser"), object: nil)
    
    }

    @objc func LoginIsApproved(_ notification: Notification){
        print("Login was Successful")
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "Sawo", sender: nil)
        
    
    }
    
    @objc func loginCONTENTapi(_ notification: Notification){
        if let data = notification.userInfo as? [String: String]
            {
                for (UserPayload, Content) in data
                {
                    PayloadApi = Content
                    print("\(UserPayload) : \(Content) ")
                }
        }
    
    }

}

