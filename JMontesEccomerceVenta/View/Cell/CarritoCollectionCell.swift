//
//  CarritoCollectionCell.swift
//  JMontesEccomerceVenta
//
//  Created by Admin on 26/05/23.
//

import UIKit
import SwipeCellKit

class CarritoCollectionCell: SwipeTableViewCell{

    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var Stepper: UIStepper!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var lblCantidad: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
