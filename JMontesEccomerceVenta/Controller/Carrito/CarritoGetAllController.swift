//
//  CarritoGetAllController.swift
//  JMontesEccomerceVenta
//
//  Created by Admin on 26/05/23.
//

import UIKit
import SwipeCellKit

class CarritoGetAllController: UITableViewController {
    
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
            
            UpdateUI()
        }
        
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return productosventas.count
            
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "carritoCell", for: indexPath) as! CarritoCollectionCell
            
            cell.delegate = self
            
            cell.lblNombre.text = productosventas[indexPath.row].producto?.Nombre
            cell.lblCantidad.text = productosventas[indexPath.row].cantidad?.description
            
            if productosventas[indexPath.row].producto?.Imagen == "" || productosventas[indexPath.row].producto?.Imagen == nil {
                cell.ImageView.image = UIImage(named: "DefaultProducto")
            }else{
                let string =  productosventas[indexPath.row].producto?.Imagen
                
                
                let newImageData = Data(base64Encoded: string!)
                if let newImageData = newImageData {
                    cell.ImageView.image = UIImage(data: newImageData)
                }
            }
            
            return cell
        }
        
        
        

    }

    extension CarritoGetAllController : SwipeTableViewCellDelegate{
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
            
            if orientation == .right{
                let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
                    
                }
                return [deleteAction]
            }
            if orientation == .left {
                let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                }
                return [updateAction]
            }
            return nil
            
            
        }
        
        func UpdateUI(){
            var result = carritoViewModel.GetAll()
            productosventas.removeAll()
            if result.Correct!{
                for objUsuario in result.Objects!{
                    let prod = objUsuario as! VentaProductos
                    productosventas.append(prod)
                }
                tableView.reloadData()
                
            }
        }
    }
