//
//  CompraViewController.swift
//  JMontesEccomerceVenta
//
//  Created by Admin on 02/06/23.
//

import UIKit
import iOSDropDown

class CompraViewController: UIViewController {
    @IBOutlet weak var ddlPago: JRDropDown!
    
    var IdPago : Int = 0
    
    override func viewDidLoad() {
        
        ddlPago.didSelect { [self] selectedText, index, id in
            self.IdPago = id
            
            
            
        }
        
        super.viewDidLoad()
        
        ddlIdPago.optionArray = []
        ddlIdPago.optionIds = []
        
        let resultPago = CarritoViewModel.GetAllPago()
               if resultPago.Correct!{
                   for objpago in resultPago.Objects!{
                let pago = objpago as! Pago
                       ddlPago.optionArray.append(pago.Nombre!)
                      // ddlPago.optionIds?.append(departamento.IdDepartamento!)
                   }
               }
    }
}
