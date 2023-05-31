//
//  RolViewController.swift
//  JMontesEcommerce
//
//  Created by Admin on 09/05/23.
//

import UIKit
//import iOSDropDown

class RolViewController: UIViewController {

    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtIdRol: UITextField!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var lblIdRol: UILabel!
    
    var IdRol : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.txtNombre.delegate = self
        //txtNombre.delegate = self
        
        print("El id del rol es:")
        print(IdRol)

        if IdRol == 0{
            //Add
            //Mostrar formulario Vacio
            self.txtIdRol.text = ""
            txtIdRol.isHidden = true
            lblIdRol.isHidden = true
            
            self.txtNombre.text = ""
            
            btnAction.backgroundColor = .green
            btnAction.setTitle("Agregar", for: .normal)
            
            //txtNombre.delegate = self
            self.view.endEditing(true)
            
        }else{
            //Update
            //GetByID(IdRol)
            //Mostrar formulario con inf del alumno/Usuario
            txtIdRol.isUserInteractionEnabled = false
            let rol =  RolViewModel.GetById(IdRol: IdRol)
            //unboxing
            let acceder = rol.Object as! Rol
                        
                self.txtIdRol.text = acceder.IdRol?.description
                self.txtNombre.text = acceder.Nombre
               
            btnAction.backgroundColor = .yellow
            btnAction.setTitle("Actualizar", for: .normal)
        }
    }
    
    @IBAction func ActionsButton(_ sender: UIButton) {
        guard txtNombre.text != "" else{
           // lblNombrevacio.text = "El campo no puede ser vacio"

            //txtNombre.  = .red
            return
        }
        
        let opcion = btnAction.titleLabel?.text
        switch opcion{
        case "Agregar":
            var rol = Rol()

            rol.Nombre = txtNombre.text!
            
            let result = RolViewModel.Add(rol: rol)
            if result.Correct! {

                let alert = UIAlertController(title: "Mensaje", message: "Rol insertado correctamente", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)

                alert.addAction(action)

                self.present(alert, animated: true, completion: nil)
                txtNombre.text = ""
            }
            break
        case "Actualizar":
            var rol = Rol()
            
            rol.IdRol = Int(txtIdRol.text!) ?? 0
            rol.Nombre = txtNombre.text!

            let result = RolViewModel.Update(rol: rol)
            if result.Correct! {
                let alert = UIAlertController(title: "Mensaje", message: "Rol actualizado correctamente", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
            }
            break
        default:
            print("Error al actualizar")
        }
    }
    }

//MARK: UITextFieldDelegate

extension RolViewController: UITextViewDelegate{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtNombre.resignFirstResponder()
        return true;
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            txtNombre.resignFirstResponder()

        }

}

   

