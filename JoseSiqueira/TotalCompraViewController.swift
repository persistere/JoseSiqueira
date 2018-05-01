//
//  TotalCompraViewController.swift
//  JoseSiqueira
//
//  Created by Jose Otavio on 26/04/2018.
//  Copyright © 2018 Jose Otavio. All rights reserved.
//

import UIKit
import CoreData

class TotalCompraViewController: UIViewController {

    @IBOutlet var lbTotalDolar: UILabel!
    @IBOutlet var lbTotalReal: UILabel!
    
    var totalDolar: Double = 0
    var totalReal: Double = 0
    
    let config = Configuration.shared
    
    var dataSource: [Produto] = []
    var format = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadProdutos()
        let dolar = UserDefaults.standard.string(forKey: "dollar")
        let iof = UserDefaults.standard.string(forKey: "iof")
        
        var results = 0.0
        dataSource.forEach { (produto) in
            if let estado = produto.estado {
                var result = produto.valor + calculateStateTax(value: produto.valor, tax: estado.tax)
                
                if produto.cartao {
                    result = result + calculateIOFValue(value: (result), iof: Double(iof!)!)
                }
                results += result
            }
        }
        
        totalDolar = results * Double(dolar!)!
        totalReal = results
        
        lbTotalReal.text = String(format: "%.2f", totalReal)
        lbTotalDolar.text = String(format: "%.2f", totalDolar)
    }
    
    func calculateStateTax(value: Double, tax: Double) -> Double {
        return value * (tax / 100)
    }
    
    func calculateIOFValue(value: Double, iof: Double) -> Double {
        return value * (iof / 100)
    }
    
    // MARK: - Methods
    func loadProdutos() {
        let fetchRequest: NSFetchRequest<Produto> = Produto.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            dataSource = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
