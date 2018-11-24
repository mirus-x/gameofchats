//
//  UserSettingsViewController.swift
//  gameofchats
//
//  Created by 2x2 on 11/14/18.
//  Copyright © 2018 2x2. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UserSettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var profileState: Bool = false
    let imagePicker = UIImagePickerController()
    
    let profileContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
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
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageView.image = UIImage(named: "wolf")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.isUserInteractionEnabled = false
        
        imageView.layer.borderWidth = 0
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    
    
    let profileEmailField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = "Email: "
        tf.textColor = Colors.loginRegBtn
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    let profileNameField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = "Name: "
        tf.textColor = Colors.loginRegBtn
        tf.isUserInteractionEnabled = false
        tf.setBottomBorder()
        return tf
    }()
    
    let profileDeleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.loginRegBtn
        button.setTitle("Delete profile", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(Colors.white, for: .normal)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.addTarget(self, action: #selector(handleProfileDelete), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.loginBgBlue
        self.setNeedsStatusBarAppearanceUpdate()
        imagePicker.delegate = self
        setupNavigationBarStyles()
        // Do any additional setup after loading the view.
        
        view.addSubview(profileContainerView)
        view.addSubview(profileImageContainerView)
        view.addSubview(profileDeleteButton)
        
        setupProfileContainerViewConstraints()
        setupProfileImageViewConstraints()
        setupProfileDeleteButtonConstraints()
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = pickedImage
        }
        
        if let selectedImage = selectedImageFromPicker{
            profileImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleProfileDelete(){
    
    }
    
    
    var profileDBHC: NSLayoutConstraint?
    @objc func saveUserProfile(){
        //save edited information to the database
        profileDBHC?.constant = 0
        
        profileEmailField.isUserInteractionEnabled = false
        profileNameField.isUserInteractionEnabled = false
        // change button state
        let rightNavButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editUserProfile))
        rightNavButton.tintColor = Colors.white
        navigationItem.rightBarButtonItem = rightNavButton
        
        profileImageView.isUserInteractionEnabled = false
    }
    
    @objc func editUserProfile(){
        // show edit information view
        
        profileDBHC?.constant = 50
        profileEmailField.isUserInteractionEnabled = true
        profileNameField.isUserInteractionEnabled = true
        //change button state (my be need to define global button ???
        let rightNavButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveUserProfile))
        rightNavButton.tintColor = Colors.white
        navigationItem.rightBarButtonItem = rightNavButton
        
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(changeUserProfileImage))
        profileImageView.addGestureRecognizer(pictureTap)
        profileImageView.isUserInteractionEnabled = true
        
    }
    
    @objc func changeUserProfileImage(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
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
        profileDeleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 12).isActive = true
        profileDeleteButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        profileDBHC = profileDeleteButton.heightAnchor.constraint(equalToConstant: 0)
        profileDBHC?.isActive = true
    }
    
    @objc func closeSettingsViewController(){
        profileEmailField.isUserInteractionEnabled = false
        profileNameField.isUserInteractionEnabled = false
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

