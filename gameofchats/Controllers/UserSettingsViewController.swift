//
//  UserSettingsViewController.swift
//  gameofchats
//
//  Created by 2x2 on 11/14/18.
//  Copyright © 2018 2x2. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UserSettingsViewController: UIViewController {
    
    var profileState: Bool = false
    
    let profileContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileBorderDevider: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.borderCololor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImageContainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 60
        container.clipsToBounds = true
        container.layer.masksToBounds = false
        container.layer.borderWidth = 3
        container.layer.borderColor = Colors.white.cgColor
        
        return container
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wolf")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        return imageView
    }()
    
    let profileEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email: "
        label.textColor = Colors.loginRegBtn
        return label
    }()
    
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name: "
        label.textColor = Colors.loginRegBtn
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.loginBgBlue
        self.setNeedsStatusBarAppearanceUpdate()
        setupNavigationBarStyles()
        // Do any additional setup after loading the view.
        
        view.addSubview(profileContainerView)
        view.addSubview(profileImageContainerView)
        
        setupProfileContainerViewConstraints()
        setupProfileImageViewConstraints()
    }
    
    
    @objc func saveUserProfile(){
        //save edited information to the database
        
        
        
        
        
        
        // change button state
        let rightNavButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editUserProfile))
        rightNavButton.tintColor = Colors.white
        navigationItem.rightBarButtonItem = rightNavButton
    }
    
    @objc func editUserProfile(){
        // show edit information view
        
        
        
        //change button state (my be need to define global button ???
        let rightNavButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveUserProfile))
        rightNavButton.tintColor = Colors.white
        navigationItem.rightBarButtonItem = rightNavButton
    }
    
    
    func setupNavigationBarStyles(){
        let leftNavButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeSettingsViewController))
        leftNavButton.tintColor = Colors.white
        navigationItem.leftBarButtonItem = leftNavButton
        
        let rightNavButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editUserProfile))
        rightNavButton.tintColor = Colors.white
        navigationItem.rightBarButtonItem = rightNavButton
        
        navigationController?.navigationBar.barTintColor = Colors.loginBgBlue
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.white]
    }
    
    var profileContainerViewHeightAncor: NSLayoutConstraint?
    func setupProfileContainerViewConstraints(){
        profileContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        profileContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        profileContainerViewHeightAncor = profileContainerView.heightAnchor.constraint(equalToConstant: 100)
        profileContainerViewHeightAncor?.isActive = true
        
        profileContainerView.addSubview(profileNameLabel)
        profileContainerView.addSubview(profileBorderDevider)
        profileContainerView.addSubview(profileEmailLabel)
        
        profileNameLabel.topAnchor.constraint(equalTo: profileContainerView.topAnchor, constant: 0).isActive=true
        profileNameLabel.leftAnchor.constraint(equalTo: profileContainerView.leftAnchor, constant: 10).isActive = true
        profileNameLabel.rightAnchor.constraint(equalTo: profileContainerView.rightAnchor, constant: -10).isActive = true
        profileNameLabel.heightAnchor.constraint(equalToConstant: 49).isActive = true
        
        profileBorderDevider.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 0).isActive = true
        profileBorderDevider.leftAnchor.constraint(equalTo: profileNameLabel.leftAnchor, constant: 0).isActive = true
        profileBorderDevider.rightAnchor.constraint(equalTo: profileNameLabel.rightAnchor, constant: 0).isActive = true
        profileBorderDevider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        profileEmailLabel.topAnchor.constraint(equalTo: profileBorderDevider.bottomAnchor, constant: 0).isActive = true
        profileEmailLabel.leftAnchor.constraint(equalTo: profileNameLabel.leftAnchor, constant: 0).isActive = true
        profileEmailLabel.rightAnchor.constraint(equalTo: profileNameLabel.rightAnchor, constant: 0).isActive = true
        profileEmailLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupProfileImageViewConstraints(){
        profileImageContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageContainerView.bottomAnchor.constraint(equalTo: profileContainerView.topAnchor, constant: -24).isActive = true
        profileImageContainerView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        profileImageContainerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        profileImageContainerView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        profileImageContainerView.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: profileImageContainerView.bottomAnchor, constant: -15).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    @objc func closeSettingsViewController(){
        profileState = false
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}


extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

