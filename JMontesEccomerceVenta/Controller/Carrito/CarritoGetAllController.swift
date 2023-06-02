//
//  CarritoGetAllController.swift
//  JMontesEccomerceVenta
//
//  Created by Admin on 26/05/23.
//

import UIKit
import SwipeCellKit

class CarritoGetAllController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var total : Double = 0
    var subtotal : Int = 0
    let carritoViewModel = CarritoViewModel ()
    var producto : [Producto] = []
    var productosventas : [VentaProductos] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        UpdateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CarritoCollectionCell", bundle: .main), forCellReuseIdentifier:"carritoCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        UpdateUI()
    }
}
        // MARK: - Table view data source
    extension CarritoGetAllController :UITableViewDataSource, UITableViewDelegate{
        
        func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return productosventas.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "carritoCell", for: indexPath) as! CarritoCollectionCell
            
            cell.delegate = self
            
            cell.lblNombre.text = productosventas[indexPath.row].producto?.Nombre
            cell.lblCantidad.text = productosventas[indexPath.row].cantidad?.description
            cell.lblSubtotal.text = productosventas[indexPath.row].producto?.Precio?.description
            
            subtotal = productosventas[indexPath.row].cantidad! * (productosventas[indexPath.row].producto?.Precio ?? 0)
            cell.lblSubtotal.text = String (subtotal)
            
            if productosventas[indexPath.row].producto?.Imagen == "" || productosventas[indexPath.row].producto?.Imagen == nil {
                cell.ImageView.image = UIImage(named: "DefaultProducto")
            }else{
                let string =  productosventas[indexPath.row].producto?.Imagen
                
                
                let newImageData = Data(base64Encoded: string!)
                if let newImageData = newImageData {
                    cell.ImageView.image = UIImage(data: newImageData)
                }
            }
            
            
            cell.Stepper.value = Double(productosventas[indexPath.row].cantidad!)
            cell.Stepper.tag = indexPath.row
            cell.Stepper.addTarget(self, action: #selector(Steeperaction), for: .touchUpInside)
            
            
            return cell
        }
        
    }
        

    

    extension CarritoGetAllController : SwipeTableViewCellDelegate{
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
            
            if orientation == .right{
                let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
                    
                    let result =  carritoViewModel.Delete(IdProducto: self.productosventas[indexPath.row].producto!.IdProducto!)

                                    if result.Correct! {
                                        let alert = UIAlertController(title: "Mensaje", message: "Producto eliminado del carrito", preferredStyle: .alert)
                                        let action = UIAlertAction(title: "Aceptar", style: .default)
                                        alert.addAction(action)
                                        self.present(alert, animated: true, completion: nil)
                                        self.UpdateUI()
                                       
                                    }else{
                                        let alert = UIAlertController(title: "Mensaje", message: "No se pudo eliminar", preferredStyle: .alert)
                                        let action = UIAlertAction(title: "Aceptar", style: .default)
                                        alert.addAction(action)
                                        self.present(alert, animated: true, completion: nil)
                                    }
                }
                return [deleteAction]
            }

            return nil
            
        }
      
        
        func UpdateUI(){
            var result = carritoViewModel.GetAll()
            productosventas.removeAll()
            if result.Correct!{
                for objProducto in result.Objects!{
                    let prod = objProducto as! VentaProductos
                    productosventas.append(prod)
                }
                tableView.reloadData()
                
            }
        }
        
        @objc func Steeperaction(sender: UIStepper){
            let indexPath = IndexPath(row: sender.tag, section: 0)
            print("sender ---> \(sender.value)")
            if sender.value >= 1{
                if carritoViewModel.Update(IdProducto: (productosventas[indexPath.row].producto?.IdProducto)!,cantidad: Int(sender.value)).Correct!{
                    total = 0.0
                    UpdateUI()
                    print("Se actualizó")
                }else{
                    print("No se puede actualizar")
                }
            }else{
                sender.value = 1
                print("Ocurrio un error")
            }
        }
    }
    
