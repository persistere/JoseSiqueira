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
    
    
    var dataSource: [Produto] = []
    var format = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadProdutos()
        let dolar = 3.2 //UserDefaults.standard.string(forKey: "dollar")
        let iof = 6.38 //UserDefaults.standard.string(forKey: "iof")
        
        var results = 0.0
        dataSource.forEach { (produto) in
            if let estado = produto.estado {
                var result = produto.valor + calculateStateTax(value: produto.valor, tax: estado.tax)
                
                if produto.cartao {
                    result = result + calculateIOFValue(value: (result), iof: Double(iof))
                }
                results += result
            }
        }
        
        lbTotalReal.text = "\(results * Double(dolar))"
        lbTotalDolar.text = "\(results)"
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
    
//    var totalDolar: Double = 0
//    var totalReal: Double = 0
//    var valorTaxaEstado: Double = 0
//    var cartao = true
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        TotalDasCompras()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        loadLabels()
//    }
//
//
//    func TotalDasCompras() {
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
//        let entityDescription = NSEntityDescription.entity(forEntityName: "Produto", in: self.context)
//
//        fetchRequest.entity = entityDescription
//
//        do {
//            let result = try self.context.fetch(fetchRequest)
//
//             for element in result {
//                let produtos = element as! Produto
//
//                totalDolar += Double(produtos.valor)
//                valorTaxaEstado = totalDolar * cc.taxaEstado/100
//
//                totalReal = totalDolar * cc.dolar + valorTaxaEstado
//
//                if(cartao == true) {
//                    totalReal += cc.iof
//                }
//            }
//
//        } catch {
//            let fetchError = error as NSError
//            print(fetchError)
//        }
//
//    }
//
//    func loadLabels() {
//        lbTotalDolar.text = String(format: "%.2f", totalDolar)
//        lbTotalReal.text = String(format: "%.2f", totalReal)
//    }
    
}
