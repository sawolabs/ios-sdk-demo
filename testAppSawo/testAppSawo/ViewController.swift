//
//  ViewController.swift
//  testAppSawo
//
//  Created by Rhytthm Mahajan on 10/12/20.
//

import UIKit
import FrameworkV1
import SwiftKeychainWrapper


class ViewController: UIViewController {
    let VC = FrameworkV1.LoginViewController()
    var PayloadApi = ""
    
    var publicKeyApp = ""
    var privateKeyApp = ""
    var sessionIdApp = ""
        
    var keychainPublicKEY = KeychainWrapper.standard.string(forKey: "publicKEY")
    var keychainPrivateKEY = KeychainWrapper.standard.string(forKey: "privateKEY")
    var keychainSessionID = KeychainWrapper.standard.string(forKey: "sessionID")

    
    @IBAction func Login(_ sender: Any) {
        present(VC, animated: true, completion: nil)
        let apiKey = ["apikey": "ab59f803-14c3-4cef-ade1-b31ec0fbef8d"]
        let identifierType = ["identifier": "email"]
        let secretKey = ["secretkey": "5f7cd216c501b54c7fe292d1vUmOUotM96qhrOCo06OfTZiz"]
        let keychainPuK = ["keychainPuk": "\(String( keychainPublicKEY ?? "not found any"))"]
        let keychainPrK = ["keychainPrk": "\(String( keychainPrivateKEY ?? "not found any"))"]
        let keychainSess = ["keychainSess": "\(String( keychainSessionID ?? "not found any"))"]
        
        print("on Login Pressed The values ....")
        print(keychainPublicKEY)
        print(keychainPrivateKEY)
        print(keychainSessionID )

        NotificationCenter.default.post(name: Notification.Name("ProductKey"), object: nil,userInfo: apiKey)
        NotificationCenter.default.post(name: Notification.Name("IdentifierType"), object:nil, userInfo: identifierType)
        NotificationCenter.default.post(name: Notification.Name("SecretType"), object:nil, userInfo: secretKey)
        NotificationCenter.default.post(name: Notification.Name("keychainPuKFramework"), object: nil,userInfo: keychainPuK)
        NotificationCenter.default.post(name: Notification.Name("ProductKeyFramework"), object: nil,userInfo: keychainPrK)
        NotificationCenter.default.post(name: Notification.Name("keychainSessFramework"), object: nil,userInfo: keychainSess)


    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view

        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginIsApproved(_:)), name: Notification.Name("LoginApproved"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loginCONTENTapi(_:)), name: Notification.Name("PayloadOfUser"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(PublicKEYApp(_:)), name: Notification.Name("publickey"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PrivateKEYApp(_:)), name: Notification.Name("privatekey"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SessionIDApp(_:)), name: Notification.Name("sessionId"), object: nil)
            
//        NotificationCenter.default.addObserver(self, selector: #selector(LoginButtonPressed(_:)), name: Notification.Name("LoginApproved"), object: nil)
        
        print(keychainPublicKEY ?? "abcdef")
        print(keychainPrivateKEY ?? "12345")

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
    
    @objc func PublicKEYApp(_ notification: Notification){
        if let data = notification.userInfo as? [String: String]
            {
                for (PublicKEYApps, valuePublic) in data
                {
                    publicKeyApp = valuePublic
                    print("\(PublicKEYApps) : \(valuePublic) ")
                    KeychainWrapper.standard.set(valuePublic, forKey: "publicKEY")
                }
        }
    }
    
    @objc func PrivateKEYApp(_ notification: Notification){
        if let data = notification.userInfo as? [String: String]
            {
                for (PrivateKEYApps, valuePrivate) in data
                {
                    privateKeyApp = valuePrivate
                    print("\(PrivateKEYApps) : \(valuePrivate) ")
                    KeychainWrapper.standard.set(valuePrivate, forKey: "privateKEY")
                }
        }
    }
    
    @objc func SessionIDApp(_ notification: Notification){
        if let data = notification.userInfo as? [String: String]
            {
                for (SessionIDApps, valueSessionID) in data
                {
                    sessionIdApp = valueSessionID
                    print("\(SessionIDApps) : \(valueSessionID) ")
                    KeychainWrapper.standard.set(valueSessionID, forKey: "sessionID")
                }
            
        }
        
    
    }

}
                        
