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

class MessagesViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogoutPress))
        
        let image = UIImage(named: "new_message_icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let user = Auth.auth().currentUser
        if user?.uid == nil{
            perform(#selector(handleLogoutPress), with: nil, afterDelay: 0)
        }else{
            let button =  UIButton(type: .system)
            button.addTarget(self, action: #selector(showUserProfileSettings), for: .touchUpInside)
            button.tintColor = Colors.systemColor
            button.setTitle(user?.displayName, for: .normal)
            self.navigationItem.titleView = button
            self.navigationItem.largeTitleDisplayMode = .automatic
        }
    }
    
    @objc func showUserProfileSettings(){
        let settingsPage = UserSettingsViewController()
        let navController = UINavigationController(rootViewController: settingsPage)
        present(navController, animated: true, completion: nil)
    }
    
    
    @objc func handleNewMessage(){
        let newMessageController = NewMessageViewController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
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

