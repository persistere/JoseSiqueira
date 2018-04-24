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
    @IBOutlet var tfEstado: UITextField!
    
    var produto: Produto!
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    var estadosManager = EstadosManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfEstado.inputView = pickerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        estadosManager.loadEstados(with: context)
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


extension AddEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return estadosManager.estados.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent: Int) -> String? {
        let estados = estadosManager.estados[row]
        return estados.title
    }
}































