//
//  ProductoCollectionCell.swift
//  JMontesEcommerce
//
//  Created by Admin on 24/05/23.
//

import UIKit

class ProductoCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
