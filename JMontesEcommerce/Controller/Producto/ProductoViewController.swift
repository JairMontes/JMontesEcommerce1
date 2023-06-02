//
//  ProductoViewController.swift
//  JMontesEcommerce
//
//  Created by Admin on 16/05/23.
//

import UIKit
import iOSDropDown


class ProductoViewController: UIViewController {
    
//    @IBOutlet weak var txtIdProducto: UITextField!
//    @IBOutlet weak var txtNombre: UITextField!
//    @IBOutlet weak var txtDepartamento: UITextField!
//    @IBOutlet weak var txtPrecio: UITextField!
//    @IBOutlet weak var txtDescripcion: UITextField!
//    @IBOutlet weak var btnAction: UIButton!
 //   @IBOutlet weak var ddlIdDepartamento: DropDown!
//    @IBOutlet weak var lblIdProducto: UILabel!
 //   @IBOutlet weak var ddlIdArea: DropDown!
    
    
   // @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var txtIdProducto: UITextField!
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtDepartamento: UITextField!
    @IBOutlet weak var txtPrecio: UITextField!
    @IBOutlet weak var txtDescripcion: UITextField!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var ddlIdDepartamento: DropDown!
    @IBOutlet weak var lblIdProducto: UILabel!
    @IBOutlet weak var ddlIdArea: DropDown!
    @IBOutlet weak var ImageView: UIImageView!
    
    
    var dbManager : DBManager? = nil
    
    var IdProducto : Int = 0
    var IdDepartamento : Int = 0
   // var IdArea : Int = 0
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {

        ddlIdDepartamento.didSelect { [self] selectedText, index, id in
            self.IdDepartamento = id
            
           /* let resultDepartamento = DepartamentoViewModel.GetByIdArea(IdArea: IdArea)
            if resultDepartamento.Correct!{
                for objdepartamento in resultDepartamento.Objects!{
                    let departamentos = objdepartamento as! Departamento
                    ddlIdDepartamento.optionArray.append(departamentos.Nombre!)
                    ddlIdDepartamento.optionIds?.append(departamentos.IdDepartamento!)
                }
            }*/
        }

        super.viewDidLoad()

        //Image delegate
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.isEditing = false


        ddlIdDepartamento.optionArray = []
        ddlIdDepartamento.optionIds = []

        ddlIdArea.optionArray = []
        ddlIdArea.optionIds = []
            /*let resultDepartamento = ProductoViewModel.GetAllDepartamento()
            if resultDepartamento.Correct!{
                for objdepartamento in resultDepartamento.Objects!{
                    let departamento = objdepartamento as! Producto
                    ddlIdDepartamento.optionArray.append((departamento.Departamento?.Nombre) ?? "Sin departamentos")
                    ddlIdDepartamento.optionIds?.append(departamento.Departamento?.IdDepartamento ?? 0)

                }
            }*/
        let resultDepartamento = DepartamentoViewModel.GetAllDepartamento()
               if resultDepartamento.Correct!{
                   for objdepartamento in resultDepartamento.Objects!{
                let departamento = objdepartamento as! Departamento
                       ddlIdDepartamento.optionArray.append(departamento.Nombre!)
                       ddlIdDepartamento.optionIds?.append(departamento.IdDepartamento!)
                   }
               }
      
        let resultArea = AreaViewModel.GetAllArea()
                     if resultArea.Correct!{
                         for objarea in resultArea.Objects!{
                      let area = objarea as! Area
                             ddlIdArea.optionArray.append(area.Nombre!)
                             ddlIdArea.optionIds?.append(area.IdArea!)
                         }
                     }
        
        
        if IdProducto == 0{
            //Add
            //Mostrar formulario Vacio
            self.txtIdProducto.text = ""
            txtIdProducto.isHidden = true
            lblIdProducto.isHidden = true
            
            self.txtNombre.text = ""
            self.txtPrecio.text = ""
            self.txtDescripcion.text = ""
           // self.txtDepartamento.text = ""
            
            
            btnAction.backgroundColor = .green
            btnAction.setTitle("Agregar", for: .normal)
        }else{
            //Update
            //GetByID(IdProducto)
            txtIdProducto.isUserInteractionEnabled = false
            let producto =  ProductoViewModel.GetById(IdProducto: IdProducto)
            //unboxing
            let acceder = producto.Object as! Producto
            
            //self.ImageView.image = acceder.Imagen
            self.txtIdProducto.text = acceder.IdProducto?.description
            self.txtNombre.text = acceder.Nombre
            self.txtPrecio.text = acceder.Precio?.description
            self.txtDescripcion.text = acceder.Descripcion
            self.txtDepartamento.text = acceder.Departamento?.Nombre
            
            
            btnAction.backgroundColor = .yellow
            btnAction.setTitle("Actualizar", for: .normal)
        }
    }
    
    
//    @IBAction func openPickerImage() {
//        self.present(imagePickerController, animated: true)
//    }
    
    @IBAction func openPickerImage() {
        self.present(imagePickerController, animated: true)
    }
    
    
    
    @IBAction func ActionButtons(_ sender: UIButton) {
    
    //  @IBAction func ActionButtons(_ sender: UIButton) {
    
        let imagen = ImageView.image
//        var producto = Producto()
  //      producto.image = convertImageToBase64(imagen: imagen)//Convertir a base 64
//        guard let stringData = Data(base64Encoded: base64String),
//              let uiImage = UIImage(data: stringData) else {
//                  print("Error, No se pudo convertir")
//                  return
//              }
        
        let opcion = btnAction.titleLabel?.text
        switch opcion{
        case "Agregar":
            var producto = Producto()
            
            producto.Nombre = txtNombre.text!
            producto.Precio = Int(txtPrecio.text!)
            producto.Descripcion = txtDescripcion.text!
            
            producto.Departamento = Departamento()
            producto.Departamento?.IdDepartamento = self.IdDepartamento
            producto.Imagen = convertToBase64()
            
            let result = ProductoViewModel.Add(producto: producto)
            if result.Correct! {
                
                let alert = UIAlertController(title: "Mensaje", message: "Producto insertado correctamente", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
                
                txtNombre.text = ""
                txtPrecio.text = ""
                txtDescripcion.text = ""
                
                txtDepartamento.text! = ""
                
            }
            break
        case "Actualizar":
            var producto = Producto()
            
            producto.IdProducto = Int(txtIdProducto.text!) ?? 0
            producto.Nombre = txtNombre.text!
            producto.Precio = Int(txtPrecio.text!)
            producto.Descripcion = txtDescripcion.text!
            
            producto.Departamento = Departamento()
            producto.Departamento?.IdDepartamento = self.IdDepartamento
            producto.Imagen = convertToBase64()
            
            let result = ProductoViewModel.Update(producto: producto)
            if result.Correct! {
                let alert = UIAlertController(title: "Mensaje", message: "Producto actualizado correctamente", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
                
                txtNombre.text = ""
                txtPrecio.text = ""
                txtDescripcion.text = ""
                txtDepartamento.text! = ""
                
            }
            break
        default:
            print("Error al actualizar")
        }
    }
    
}

// MARK: ImageView
    extension ProductoViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            let data = info[.originalImage]
            self.ImageView.image = info[.originalImage] as! UIImage

            dismiss(animated: true)
       }
        
        /* func convertImageToBase64 (img: UIImage) -> String {
            let imageData:NSData = img.jpegData(compressionQuality: 0.50)! as NSData //UIImagePNGRepresentation(img)
            let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
            return imgString
        }*/
        func convertToBase64() -> String{
               let base64 = (ImageView.image?.pngData()?.base64EncodedString())!
                      //print("Base64 \(base64)")
                      return base64
           }

    }
