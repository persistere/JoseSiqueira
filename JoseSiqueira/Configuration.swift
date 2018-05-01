//
//  Configuration.swift
//  JoseSiqueira
//
//  Created by Jose Otavio on 27/04/2018.
//  Copyright © 2018 Jose Otavio. All rights reserved.
//

import Foundation

enum UserDefaultsKeys: String {
    case dollar = "dollar"
    case iof = "iof"
}

class Configuration {
    let defaults = UserDefaults.standard
    static var shared: Configuration = Configuration()
    
    var dollar: Double {
        get {
            return defaults.double(forKey: UserDefaultsKeys.dollar.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.dollar.rawValue)
        }
    }
    
    var iof: Double {
        get {
            return defaults.double(forKey: UserDefaultsKeys.iof.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.iof.rawValue)
        }
    }
    
    private init(){
        
    }
}




