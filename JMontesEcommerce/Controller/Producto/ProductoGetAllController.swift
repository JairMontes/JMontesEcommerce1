//
//  ProductoGetAllController.swift
//  JMontesEcommerce
//
//  Created by Admin on 16/05/23.
//

import UIKit
import SwipeCellKit


class ProductoGetAllController: UITableViewController {

    var productos : [Producto] = []

    //let dbManager = DBManager()
    
    var IdProducto : Int = 0
    var IdDepartamento : Int = 0
    var IdArea : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registrar la celda
        tableView.register(UINib(nibName: "productoCell", bundle: .main), forCellReuseIdentifier: "productoCell")
        updateUI()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productoCell", for: indexPath) as! productoCell
        
        cell.delegate = self
        
        cell.lblNombre.text = productos[indexPath.row].Nombre
        cell.lblPrecio.text = productos[indexPath.row].Precio
        cell.lblDescripcion.text = productos[indexPath.row].Descripcion
        //cell.lbldepartamento.text = productos[indexPath.row].Departamento?.IdDepartamento?.description
        
        //Image
        if productos[indexPath.row].Imagen == "" || productos[indexPath.row].Imagen == nil {
            cell.ImagenView.image = UIImage(named: "DefaultProducto")
        }else{
//            let imagenData : Data = //Proceso inverso de base64 a Data
//            cell.ImagenView.image = UIImage(data: imagenData)
            
            let string =  productos[indexPath.row].Imagen
                                          
            let newImageData = Data(base64Encoded: string!)
            if let newImageData = newImageData {
            cell.ImagenView.image = UIImage(data: newImageData)
            }
               
        }
        
        return cell
    }
}

//SWIPE
extension ProductoGetAllController : SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
                print(indexPath.row)
                
                //CODIGO A EJECUTAR
                let result = ProductoViewModel.Delete(IdProducto: self.productos[indexPath.row].IdProducto!)
                
                if result.Correct! {
                    print("Se elimino el registro")
                    self.updateUI()
                    
                }else{
                    print("Ocurrio un error")
                }
                
            }
            return [deleteAction]
        }
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                self.IdProducto = self.productos[indexPath.row].IdProducto!
                
                self.performSegue(withIdentifier: "ProductoFormController", sender: self)
            }
            updateAction.backgroundColor = .systemBlue
            return [updateAction]
        }
        return nil
    }
    
    func updateUI(){
        var result = ProductoViewModel.GetAll()
        productos.removeAll()
        if result.Correct! {
            for objProducto in result.Objects! {
                let producto = objProducto as! Producto
                productos.append(producto)
            }
            tableView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ProductoFormController"{
            let formControl = segue.destination as! ProductoViewController
            formControl.IdProducto = self.IdProducto
            //formControl.IdArea = self.IdArea
        }
    }
    
}
