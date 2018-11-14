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
    
    let navigationTitleButton: UIButton = {
        let button =  UIButton(type: .system)
        button.addTarget(self, action: #selector(showUserProfileSettings), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func showUserProfileSettings(){
        print("user profile settings")
    }
    
//    self.navigationItem.titleView = button

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogoutPress))
        
        let image = UIImage(named: "new_message_icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
        
        checkIfUserIsLogedIn()
    }
    
    @objc func handleNewMessage(){
        let newMessageController = NewMessageViewController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    func checkIfUserIsLogedIn(){
        if Auth.auth().currentUser?.uid == nil{
            perform(#selector(handleLogoutPress), with: nil, afterDelay: 0)
        }else{
        
            // fetch data
            let uid = Auth.auth().currentUser?.uid
            
            var ref: DatabaseReference!
            ref = Database.database().reference().child("users").child(uid!)
            ref.observe(.value, with: { (snapshot) in
                if let dictionary  = snapshot.value as? [String:Any]{
                    self.navigationTitleButton.setTitle(dictionary["name"] as? String, for: .normal)
                    self.navigationItem.titleView = self.navigationTitleButton
                }
            }, withCancel: nil)
            
            
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

