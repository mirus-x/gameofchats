//
//  ViewController.swift
//  gameofchats
//
//  Created by 2x2 on 11/11/18.
//  Copyright © 2018 2x2. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogoutPress))
        
        if Auth.auth().currentUser?.uid == nil{
            perform(#selector(handleLogoutPress), with: nil, afterDelay: 0)
        }
    }
    
    @objc func handleLogoutPress(){
        let firAuth = Auth.auth()
        do{
            try firAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out : %@", signOutError)
        }
        
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }

}

