//
//  Double+Extention.swift
//  gameofchats
//
//  Created by 2x2 on 11/26/18.
//  Copyright © 2018 2x2. All rights reserved.
//

import Foundation

extension Double {
    func format(f: String) -> String {
        return NSString(format: "%\(f)f" as NSString, self) as String
    }
    
    func toString() -> String {
        return String(format: "%.1f",self)
    }
    
    func toInt() -> Int{
        var temp:Int64 = Int64(self)
        return Int(temp)
    }
}
