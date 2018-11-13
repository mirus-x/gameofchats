//
//  ViewController.swift
//  gameofchats
//
//  Created by 2x2 on 11/11/18.
//  Copyright © 2018 2x2. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        view.backgroundColor = .purple
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogoutPress))
    }
    
    @objc func handleLogoutPress(){
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }

}

