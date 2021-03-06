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
    @IBOutlet var btCover: UIButton!
    @IBOutlet var swCartao: UISwitch!
    
    var produto: Produto!
    var formatter = NumberFormatter()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        return pickerView
    }()
    
    var estadosManager = EstadosManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btAddEdit.isEnabled = false
        btAddEdit.alpha = 0.5
        
        if produto != nil {
            title = "Editar Produto"
            btAddEdit.setTitle("ALTERAR", for: .normal)
            
            tfTitle.text = produto.title
            tfValor.text = String(produto.valor)
            
            swCartao.isOn = produto.cartao
 
            ivCover.image = produto.cover as? UIImage

            if let estado = produto.estado, let index = estadosManager.estados.index(of: estado) {
                tfEstado.text = estado.title
                
                pickerView.selectRow(index, inComponent: 0, animated: false)
            }
            

            if produto.cover != nil {
                btCover.setTitle(nil, for: .normal)
            }
            
        }
        
        prepareEstadosTextField()
    }
    
    func prepareEstadosTextField() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.tintColor = UIColor(named: "main")
        
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [btCancel, btFlexibleSpace, btDone]
        
        tfEstado.inputView = pickerView
        tfEstado.inputAccessoryView = toolbar
    }
    
    @objc func cancel() {
        tfEstado.resignFirstResponder()
    }
    
    @objc func done() {
        tfEstado.text = estadosManager.estados[pickerView.selectedRow(inComponent: 0)].title
        cancel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        estadosManager.loadEstados(with: context)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func addEditCover(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar poster", message: "De onde você quer escolher o poster?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default, handler: { (action: UIAlertAction) in
                self.selectPicture(sourceType: .camera)
            })
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Álbum de fotos", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(photosAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func selectPicture(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.navigationBar.tintColor = UIColor(named: "main")
        present(imagePicker, animated: true, completion: nil)
    }
    
    func validaCampos(erro: String) {
        btAddEdit.isEnabled = false
        btAddEdit.alpha = 0.5
        let alert = UIAlertController(title: "Atenção", message: erro, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        context.undo()
        return
    }
    
    
    @IBAction func addEditProduto(_ sender: UIButton) {
        if produto == nil {
            produto = Produto(context: context)
        }
        
        produto.title = tfTitle.text

        guard let valor = formatter.number(from: tfValor.text!)?.doubleValue else { return }
        produto.valor =  valor
        
        if !tfEstado.text!.isEmpty {
            let estado = estadosManager.estados[pickerView.selectedRow(inComponent: 0)]
            produto.estado = estado
        }
        
        produto.cover = ivCover.image
        
        produto.cartao = swCartao.isOn

        do {
            try context.save()
        } catch {
            print(error.localizedDescription )
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSairTeclado(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
        if let title = tfTitle.text, title.count > 0 {
            btAddEdit.isEnabled = true
            btAddEdit.alpha = 1
        } else { validaCampos(erro: "O nome do produto de ser preenchido")}
        
        if let estado = tfEstado.text, estado.count > 0 {
            btAddEdit.isEnabled = true
            btAddEdit.alpha = 1
        } else { validaCampos(erro: "Voce deve selecionar um estado")}
        
        if let valor = tfValor.text, valor.count > 0 {
            btAddEdit.isEnabled = true
            btAddEdit.alpha = 1
        } else { validaCampos(erro: "Voce inserir um valor")}
        
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


extension AddEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        ivCover.image = image
        btCover.setTitle(nil, for: .normal)
        dismiss(animated: true, completion: nil)
    }
}






























