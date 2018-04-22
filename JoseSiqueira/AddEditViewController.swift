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
    
}
































