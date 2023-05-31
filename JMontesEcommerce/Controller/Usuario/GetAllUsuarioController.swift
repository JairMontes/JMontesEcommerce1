//
//  GetAllUsuarioController.swift
//  JMontesEcommerce
//
//  Created by Admin on 03/05/23.
//

import UIKit
import SwipeCellKit

class GetAllUsuarioController: UITableViewController {
    
    var usuarios : [Usuario] = []

    let dbManager = DBManager()
    
    var IdUsuario : Int = 0
    var IdRol : Int = 0

    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registrar la celda
        tableView.register(UINib(nibName: "usuarioCell", bundle: .main), forCellReuseIdentifier: "usuarioCell")
        updateUI()
//        var result = UsuarioViewModel.GetAll()
//        if result.Correct!{
//            for objUsuario in result.Objects!{
//                let usuario = objUsuario as! Usuario //Unboxing
//                usuarios.append(usuario)
          //  }
        //}
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usuarios.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //  let cell = tableView.dequeueReusableCell(withIdentifier: "usuarioCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "usuarioCell", for: indexPath) as! usuarioCell
        
        cell.delegate = self
        
        cell.lblNombre.text = usuarios[indexPath.row].Nombre
        cell.lblApellidoPaterno.text = usuarios[indexPath.row].ApellidoPaterno
        cell.lblFechaNacimiento.text = usuarios[indexPath.row].FechaNacimiento
        cell.lblUsername.text = usuarios[indexPath.row].Username
        cell.lblNombreRol.text = usuarios[indexPath.row].Rol?.Nombre
        
        
        //usuario.IdUsuario = Int(txtIdUsuario.text!) ?? 0
        return cell
    }
}

//SWIPE
extension GetAllUsuarioController : SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
                print(indexPath.row)
                
                //CODIGO A EJECUTAR
                let result = UsuarioViewModel.Delete(IdUsuario: self.usuarios[indexPath.row].IdUsuario!)
                
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
                
                self.IdUsuario = self.usuarios[indexPath.row].IdUsuario!
                
                self.performSegue(withIdentifier: "UsuarioFormController", sender: self)
            }
            updateAction.backgroundColor = .systemBlue
            return [updateAction]
        }
        return nil
    }
    
    func updateUI(){
        var result = UsuarioViewModel.GetAll()
        usuarios.removeAll()
        if result.Correct! {
            for objUsuario in result.Objects! {
                let usuario = objUsuario as! Usuario
                usuarios.append(usuario)
            }
            tableView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UsuarioFormController"{
            let formControl = segue.destination as! ViewController
            formControl.IdUsuario = self.IdUsuario
        }
    }
}
