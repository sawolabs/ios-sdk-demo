//
//  ViewController.swift
//  SawoTestApp
//
//  Created by Rhytthm Mahajan on 28/10/20.
//

import UIKit
import FRAMEWORK

class ViewController: UIViewController {
    let VC = FRAMEWORK.LoginViewController()
    var PayloadApi = ""

    @IBAction func Login(_ sender: Any) {
        present(VC, animated: true, completion: nil)
        let apiKey = ["apikey": "495705a7-f0ff-4c22-98f4-62896b338bd2"]
        //495705a7-f0ff-4c22-98f4-62896b338bd2
        //<ADD-YOUR-KEY-HERE>
        let identifierType = ["identifier": "email"]
        //email
        //<ADD-IDENTIFIER-HERE>
        let secretKey = ["secretkey": "5f7a08e816af29f6aad5b7f2WsZPQMaW5oZGNuEXbdewXWGF"]
        // 5f7a08e816af29f6aad5b7f2WsZPQMaW5oZGNuEXbdewXWGF
        // <ADD-YOUR-SECRET-KEY-HERE>
        NotificationCenter.default.post(name: Notification.Name("ProductKey"), object: nil,userInfo: apiKey)
        NotificationCenter.default.post(name: Notification.Name("IdentifierType"), object:nil, userInfo: identifierType)
        NotificationCenter.default.post(name: Notification.Name("SecretType"), object:nil, userInfo: secretKey)
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

