//
//  LoginController.swift
//  JMontesEcommerce
//
//  Created by Admin on 22/05/23.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblCorreovacio: UILabel!
    @IBOutlet weak var lblPasswordvacio: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogin() {
        
        guard txtEmail.text != "" else{
            lblCorreovacio.text = "El campo no puede ser vacio"
            txtEmail.layer.borderColor = UIColor.red.cgColor
            txtEmail.layer.borderWidth = 2
            return
        }
        
        guard txtPassword.text != "" else{
            lblPasswordvacio.text = "El campo no puede ser vacio"
            txtPassword.layer.borderColor = UIColor.red.cgColor
            txtPassword.layer.borderWidth = 2
            return
        }
        guard let correo = txtEmail.text else{
            return
        }
        guard let password = txtPassword.text else{
            return
        }
        
        Auth.auth().signIn(withEmail: correo, password: password) { [weak self] authResult, error in
            
            if let ex = error{
                let alert = UIAlertController(title: "Mensaje", message: "Ocurrio un error,el usuario y-o contraseña no son válidos", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                
                self?.present(alert, animated: true, completion: nil)
                return
            }
            if let correct = authResult{
                self?.performSegue(withIdentifier: "IngresoFormController", sender: self)
            }
            guard let strongSelf = self else { return }
            
            
        }
    }
}
    
