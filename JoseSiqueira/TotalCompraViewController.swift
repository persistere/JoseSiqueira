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
    var valorTaxaEstado: Double = 0
    var cartao = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TotalDasCompras()
    }

    override func viewWillAppear(_ animated: Bool) {
        loadLabels()
    }
    
    func TotalDasCompras() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: "Produto", in: self.context)
        
        fetchRequest.entity = entityDescription
        
        do {
            let result = try self.context.fetch(fetchRequest)
            
             for element in result {
                let produtos = element as! Produto
                
                totalDolar += Double(produtos.valor)
                valorTaxaEstado = totalDolar * cc.taxaEstado/100
                
                totalReal = totalDolar * cc.dolar + valorTaxaEstado
                
                if(cartao == true) {
                    totalReal += cc.iof
                }
            }

        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
    }
    
    func loadLabels() {
        lbTotalDolar.text = String(format: "%.2f", totalDolar)
        lbTotalReal.text = String(format: "%.2f", totalReal)
    }
    
}
