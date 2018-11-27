//
//  UserSettingsViewController+Constraints.swift
//  gameofchats
//
//  Created by 2x2 on 11/24/18.
//  Copyright © 2018 2x2. All rights reserved.
//

import UIKit

extension UserSettingsViewController {
    
    static var profileContainerViewHeightAncor: NSLayoutConstraint?
    
    func setupProfileContainerViewConstraints(){
        profileContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        profileContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        UserSettingsViewController.profileContainerViewHeightAncor = profileContainerView.heightAnchor.constraint(equalToConstant: 100)
        UserSettingsViewController.profileContainerViewHeightAncor?.isActive = true
        
        profileContainerView.addSubview(profileNameField)
        profileContainerView.addSubview(profileEmailField)
        
        profileNameField.topAnchor.constraint(equalTo: profileContainerView.topAnchor, constant: 0).isActive=true
        profileNameField.leftAnchor.constraint(equalTo: profileContainerView.leftAnchor, constant: 10).isActive = true
        profileNameField.rightAnchor.constraint(equalTo: profileContainerView.rightAnchor, constant: -10).isActive = true
        profileNameField.heightAnchor.constraint(equalToConstant: 49).isActive = true
        
        profileEmailField.topAnchor.constraint(equalTo: profileNameField.bottomAnchor, constant: 1).isActive = true
        profileEmailField.leftAnchor.constraint(equalTo: profileNameField.leftAnchor, constant: 0).isActive = true
        profileEmailField.rightAnchor.constraint(equalTo: profileNameField.rightAnchor, constant: 0).isActive = true
        profileEmailField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupProfileImageViewConstraints(){
        profileImageContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageContainerView.bottomAnchor.constraint(equalTo: profileContainerView.topAnchor, constant: -24).isActive = true
        profileImageContainerView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        profileImageContainerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        profileImageContainerView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        profileImageContainerView.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: profileImageContainerView.bottomAnchor, constant: 0).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    func setupProfileDeleteButtonConstraints(){
        profileDeleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileDeleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
        profileDeleteButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        profileDBHC = profileDeleteButton.heightAnchor.constraint(equalToConstant: 0)
        profileDBHC?.isActive = true
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
    
    
    
}
