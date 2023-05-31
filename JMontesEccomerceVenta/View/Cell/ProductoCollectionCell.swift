//
//  ProductoCollectionCell.swift
//  JMontesEccomerceVenta
//
//  Created by Admin on 26/05/23.
//

import UIKit

class ProductoCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
