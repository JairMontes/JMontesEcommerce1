//
//  usuarioCell.swift
//  JMontesEcommerce
//
//  Created by Admin on 03/05/23.
//

import UIKit
import SwipeCellKit

class usuarioCell: SwipeTableViewCell {

    
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblFechaNacimiento: UILabel!
    @IBOutlet weak var lblApellidoPaterno: UILabel!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblNombreRol: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
