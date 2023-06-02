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
    @IBOutlet weak var lblCantidad: UILabel!
    @IBOutlet weak var Stepper: UIStepper!
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
