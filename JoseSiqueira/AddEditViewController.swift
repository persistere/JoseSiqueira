//
//  AddEditViewController.swift
//  JoseSiqueira
//
//  Created by Jose Otavio on 20/04/2018.
//  Copyright © 2018 Jose Otavio. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tfValor: UITextField!
    @IBOutlet var ivCover: UIImageView!
    @IBOutlet var btAddEdit: UIButton!
    
    var produto: Produto!
//    var formatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func addEditProduto(_ sender: UIButton) {
        if produto == nil {
            produto = Produto(context: context)
        }
        
        produto.title = tfTitle.text
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription )
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSairTeclado(_ sender: Any) {
        //self.resignFirstResponder()
        view.endEditing(true)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let double = formatter.number(from: textfield.text!)?.doubleValue else { return }
//        print(double)
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
































