//
//  ViewController.swift
//  JMontesEcommerce
//
//  Created by Admin on 28/04/23.
//

import UIKit
import SwipeCellKit
import iOSDropDown


class ViewController: UIViewController{
    
    @IBOutlet weak var txtIdUsuario: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellidoPaterno: UITextField!
    @IBOutlet weak var txtApellidoMaterno: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtFechaNacimiento: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
   
    @IBOutlet weak var txtIdRol: UITextField!
    
    
    @IBOutlet weak var btnAction: UIButton!
    //let dbmanager = DBManager()
    
    @IBOutlet weak var lblIdUsuario: UILabel!
    @IBOutlet weak var lblNombrevacio: UILabel!
    @IBOutlet weak var lblApellidovacio: UILabel!
    @IBOutlet weak var lblUsernamevacio: UILabel!
    @IBOutlet weak var lblFechavacia: UILabel!
    @IBOutlet weak var lblPasswordvacio: UILabel!
    
    @IBOutlet weak var ddlIdRol: DropDown!
    
    var dbManager : DBManager? = nil
    
    var IdUsuario : Int = 0
    var IdRol : Int = 0
    
    override func viewDidLoad() {
       
        print("El id del usuario es:")
        print(IdUsuario)
        
        ddlIdRol.didSelect { selectedText, index, id in
            self.IdRol = id
        }
        
        super.viewDidLoad()
       
        print("Se ejecuto ViewDidLoad Form")
        
        ddlIdRol.optionArray = []
        ddlIdRol.optionIds = []
       
        let resultRol = RolViewModel.GetAll()
        if resultRol.Correct!{
            for objrol in resultRol.Objects!{
         let rol = objrol as! Rol
                ddlIdRol.optionArray.append(rol.Nombre!)
                ddlIdRol.optionIds?.append(rol.IdRol!)
            }
        }
        
      
        if IdUsuario == 0{
            //Add
            //Mostrar formulario Vacio
            self.txtIdUsuario.text = ""
            txtIdUsuario.isHidden = true
            lblIdUsuario.isHidden = true
            
            self.txtNombre.text = ""
            self.txtApellidoPaterno.text = ""
            self.txtApellidoMaterno.text = ""
            self.txtUsername.text = ""
            self.txtFechaNacimiento.text = ""
            self.txtPassword.text = ""
          
            
            btnAction.backgroundColor = .green
            btnAction.setTitle("Agregar", for: .normal)
        }else{
            //Update
            //GetByID(IdAlumno)
            //Mostrar formulario con inf del alumno/Usuario
            txtIdUsuario.isUserInteractionEnabled = false
            let usuario =  UsuarioViewModel.GetById(IdUsuario: IdUsuario)
            //unboxing
            let acceder = usuario.Object as! Usuario
                        
                self.txtIdUsuario.text = acceder.IdUsuario?.description
                self.txtNombre.text = acceder.Nombre
                self.txtApellidoPaterno.text = acceder.ApellidoPaterno
                self.txtApellidoMaterno.text = acceder.ApellidoMaterno
                self.txtUsername.text = acceder.Username
                self.txtFechaNacimiento.text = acceder.FechaNacimiento
                self.txtPassword.text = acceder.Password
                self.txtIdRol.text = acceder.Rol?.Nombre
            
           
            btnAction.backgroundColor = .yellow
            btnAction.setTitle("Actualizar", for: .normal)
        }
    }
    
    //let result = Usuario.GetAll(DbManager: dbmanager)
    
    //var IdUsuario = 2
    //let result = Usuario.GetById(IdUsuario: IdUsuario, DbManager: dbmanager)
    //    @IBAction func btnRecuperarDatosAction() {
    //        //Interpolación
    //        let alumno = Alumno()
    //        alumno.IdAlumno = Int(txtIdAlumno.text!)
    //        alumno.Nombre = txtNombre.text!
    //        alumno.ApellidoPaterno = txtApellidoPaterno.text!
    //
    //    }
    
    
    @IBAction func ActionButtons(_ sender: UIButton) {
        guard txtNombre.text != "" else{
            lblNombrevacio.text = "El campo no puede ser vacio"
            txtNombre.layer.borderColor = UIColor.red.cgColor
            txtNombre.layer.borderWidth = 2
            return
        }
        guard txtApellidoPaterno.text != "" else{
            lblApellidovacio.text = "Registrar un apellido"
            txtNombre.layer.borderColor = UIColor.red.cgColor
            txtNombre.layer.borderWidth = 2
            return
        }
        guard txtUsername.text != "" else{
            lblUsernamevacio.text = "Ingresa un username"
            txtNombre.layer.borderColor = UIColor.red.cgColor
            txtNombre.layer.borderWidth = 2
            return
        }
        guard txtFechaNacimiento.text != "" else{
            lblFechavacia.text = "Ingresa una fecha"
            txtNombre.layer.borderColor = UIColor.red.cgColor
            txtNombre.layer.borderWidth = 2
            return
        }
        guard txtPassword.text != "" else{
            lblPasswordvacio.text = "Ingresar un password"
            txtNombre.layer.borderColor = UIColor.red.cgColor
            txtNombre.layer.borderWidth = 2
            return
        }

        let opcion = btnAction.titleLabel?.text
                        switch opcion{
                        case "Agregar":
                            var usuario = Usuario()
                            
                            usuario.Nombre = txtNombre.text!
                            usuario.ApellidoPaterno = txtApellidoPaterno.text!
                            usuario.ApellidoMaterno = txtApellidoMaterno.text!
                            usuario.Username = txtUsername.text!
                            usuario.FechaNacimiento = txtFechaNacimiento.text!
                            usuario.Password = txtPassword.text!
                            
                            usuario.Rol = Rol()
                            usuario.Rol?.IdRol = self.IdRol
                            
                            let result = UsuarioViewModel.Add(usuario: usuario)
                            if result.Correct! {
                                let alert = UIAlertController(title: "Mensaje", message: "Usuario Agregado", preferredStyle: .alert)
                                let action = UIAlertAction(title: "Aceptar", style: .default)
                                alert.addAction(action)
                                alert.addAction(action)
                                self.present(alert,animated: true,completion: nil)
                                
                                txtIdUsuario.text! = ""
                                txtNombre.text! = ""
                                txtApellidoPaterno.text! = ""
                                txtApellidoMaterno.text! = ""
                                txtUsername.text! = ""
                                txtFechaNacimiento.text! = ""
                                txtPassword.text! = ""
                                ddlIdRol.text! = ""
                            }
                            break
        case "Actualizar":
            var usuario = Usuario()

            usuario.IdUsuario = Int(txtIdUsuario.text!) ?? 0
            usuario.Nombre = txtNombre.text!
            usuario.ApellidoPaterno = txtApellidoPaterno.text!
            usuario.ApellidoMaterno = txtApellidoMaterno.text!
            usuario.Username = txtUsername.text!
            usuario.FechaNacimiento = txtFechaNacimiento.text!
            usuario.Password = txtPassword.text!
            usuario.Rol = Rol()
            usuario.Rol?.IdRol = self.IdRol


            let result = UsuarioViewModel.Update(usuario: usuario)
            if result.Correct! {
                let alert = UIAlertController(title: "Mensaje", message: "Usuario actualizado correctamente", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
                
                txtNombre.text = ""
                txtApellidoPaterno.text = ""
                txtApellidoMaterno.text = ""
                txtUsername.text = ""
                txtFechaNacimiento.text = ""
                txtPassword.text = ""
                txtIdRol.text! = ""
                
            }
            break
        default:
            print("Error al actualizar")
        }
    }
    
}


