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
    
    var dolar: Double = 3.2
    var iof: Double = 6.38
    var taxaEstado: Double = 7
    var totalCompra: Double = 0
    
    let formatter = NumberFormatter()
    
    var valorIof: Double {
        return (totalCompra+taxaEstado) * iof/100
    }
    
    
    func convertToDouble(_ string: String) -> Double {
        formatter.numberStyle = .none
        return formatter.number(from: string)!.doubleValue
    }
    
    private init(){
        formatter.usesGroupingSeparator = true
    }
}
