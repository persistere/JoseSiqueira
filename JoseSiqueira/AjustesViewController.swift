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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formartView()
    }
    
    func formartView() {
//        tfDolar.setValue(config.dollar, forKey: "dolar")
//        tfIof.setValue(config.iof, forKey: "iof")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
