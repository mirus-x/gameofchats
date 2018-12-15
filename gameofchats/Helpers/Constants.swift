//
//  Constants.swift
//  gameofchats
//
//  Created by 2x2 on 11/11/18.
//  Copyright © 2018 2x2. All rights reserved.
//

import UIKit

struct Colors {
    static let loginBgBlue = UIColor(r: 61, g: 91, b: 151)
    static let loginRegBtn = UIColor(r: 80, g: 101, b: 161)
    static let borderCololor = UIColor(r: 220, g: 220, b: 220)
    static let systemColor = UIColor(r: 44, g: 140, b: 250)
    static let white = UIColor.white
    
}

struct FontSizes {
    static let x16 = UIFont.systemFont(ofSize: 16)
}


struct PathUrls {
    static let firebase = "https://gameofchats-lbta.firebaseio.com/"
    static let firestore = "gs://gameofchats-lbta.appspot.com"
}

extension UIColor{
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}


