//
//  EstadosTableViewController.swift
//  JoseSiqueira
//
//  Created by Jose Otavio on 20/04/2018.
//  Copyright © 2018 Jose Otavio. All rights reserved.
//

import UIKit

class EstadosTableViewController: UITableViewController {

    var estadosManager = EstadosManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEstados()
    }
    
    func loadEstados() {
        estadosManager.loadEstados(with: context)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addEstados(_ sender: UIBarButtonItem) {
        showAlert(with: nil)
    }
    
    func showAlert(with estado: Estado? ) {
        
        let title = estado == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + "Estado", message: nil, preferredStyle: .alert )
        //var formatter = NumberFormatter()
        
        alert.addTextField {(textField) in textField.placeholder = "Nome do Estado"
            if let name = estado?.title {
                textField.text = name
            }
        }
        
        
        alert.addTextField {(textField) in textField.placeholder = "Imposto"
            if let name = estado?.title {
                textField.text = name
            }
        }
        
        alert.addAction(UIAlertAction(title: title, style: .default, handler: {(action) in
            let estado = estado ?? Estado(context: self.context)
            estado.title = alert.textFields?.first?.text
            do {
                try self.context.save()
                self.loadEstados()
            } catch {
                print(error.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.view.tintColor = UIColor(named: "second")
        present(alert, animated: true, completion: nil)
        
        
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return estadosManager.estados.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let estado = estadosManager.estados[indexPath.row]
        cell.textLabel?.text = estado.title

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
