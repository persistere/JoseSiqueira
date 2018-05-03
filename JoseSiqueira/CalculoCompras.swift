//
//  CalculoCompras.swift
//  JoseSiqueira
//
//  Created by Jose Otavio on 26/04/2018.
//  Copyright © 2018 Jose Otavio. All rights reserved.
//

import Foundation

class  CalculoCompras {
    static let shared = CalculoCompras()
        
    let formatter = NumberFormatter()
    
    func convertToDouble(_ string: String) -> Double {
        formatter.numberStyle = .none
        return formatter.number(from: string)!.doubleValue
    }
    
    private init(){
        formatter.usesGroupingSeparator = true
    }
}
