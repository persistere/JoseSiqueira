//
//  AjustesViewController.swift
//  JoseSiqueira
//
//  Created by Jose Otavio on 26/04/2018.
//  Copyright © 2018 Jose Otavio. All rights reserved.
//

import UIKit

class AjustesViewController: UIViewController {

    @IBOutlet var tfDolar: UITextField!
    @IBOutlet var tfIof: UITextField!
    
    let config = Configuration.shared
    var formatter = NumberFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        formartView()
    }
    
    func formartView() {
        tfDolar.text = UserDefaults.standard.string(forKey: "dollar")
        tfIof.text = UserDefaults.standard.string(forKey: "iof")
    }
    
    func save() {
        UserDefaults.standard.set(tfDolar.text, forKey: "dollar")
        UserDefaults.standard.set(tfIof.text, forKey: "iof")
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        save()
    }
    
}
