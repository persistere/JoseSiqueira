//
//  ProdutosTableViewCell.swift
//  JoseSiqueira
//
//  Created by Jose Otavio on 20/04/2018.
//  Copyright © 2018 Jose Otavio. All rights reserved.
//

import UIKit

class ProdutosTableViewCell: UITableViewCell {

    @IBOutlet var ivCover: UIImageView!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbValor: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with produto: Produto) {
        let dollar = String(produto.valor)
        
        lbTitle.text = produto.title ?? ""
        lbValor.text =  "US$ \(dollar)"
        
        if let image = produto.cover as? UIImage {
            ivCover.image = image
        } else {
            ivCover.image = UIImage(named: "noCover")
        }
    }
    
    
}
