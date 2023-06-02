//
//  ProductoGetAllCollectionController.swift
//  JMontesEccomerceVenta
//
//  Created by Admin on 26/05/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProductoGetAllCollectionController: UICollectionViewController {
    
    let carritoViewModel = CarritoViewModel()
    var producto : [Producto] = []
    var IdDepartamento : Int = 0
    var Id : Int = 0
    
    var datotxt : String = ""
    
    
    @IBOutlet var productoCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        collectionView.register(UINib(nibName: "ProductoCollectionCell", bundle: .main), forCellWithReuseIdentifier:"productoCell")
        
        productoCollection.delegate = self
        productoCollection.dataSource = self
        
        print("el area es: \(IdDepartamento)")
        print("el area es: \(datotxt)")
        
        if IdDepartamento == 0{
            
            var result = ProductoViewModel.GetByNombre(Sentencia: datotxt)
            producto.removeAll()
            if result.Correct!{
                for objdepartamento in result.Objects!{
                    let resultado = objdepartamento as! Producto
                    //Unboxing
                    producto.append(resultado)
                }
                collectionView?.reloadData()
            }
            
        }else{
            
            var result = ProductoViewModel.GetByIdDepartamento(IdDepartamento: IdDepartamento)
            producto.removeAll()
            if result.Correct!{
                for objdepartamento in result.Objects!{
                    let resultado = objdepartamento as! Producto
                    //Unboxing
                    producto.append(resultado)
                }
                collectionView?.reloadData()
            }
        }
        
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return producto.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productoCell", for: indexPath) as! ProductoCollectionCell
        
        
        cell.lblNombre.text = producto[indexPath.row].Nombre
        cell.lblPrecio.text = producto[indexPath.row].Precio?.description
        cell.lblDescripcion.text = producto[indexPath.row].Descripcion
        
        if producto[indexPath.row].Imagen == "" || producto[indexPath.row].Imagen == nil {
            cell.ImageView.image = UIImage(named: "DefaultProducto")
        }else{
            let string =  producto[indexPath.row].Imagen
            
            
            let newImageData = Data(base64Encoded: string!)
            if let newImageData = newImageData {
                cell.ImageView.image = UIImage(data: newImageData)
            }
        }
        
        cell.btnAdd.tag = indexPath.row
        cell.btnAdd.addTarget(self, action: #selector(AddCarrito), for: .touchUpInside)
        
        return cell
    }
    
    @objc func AddCarrito(sender : UIButton){
        let idProducto = producto[sender.tag].IdProducto!
        
        let result = carritoViewModel.Add(idProducto)
        if result.Correct! {
            
            let alert = UIAlertController(title: "Mensaje", message: "Producto añadido", preferredStyle: .alert)
            let action = UIAlertAction(title: "Aceptar", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "Mensaje", message: "Error,No se pudo añadir el producto", preferredStyle: .alert)
                      let action = UIAlertAction(title: "Aceptar", style: .default)
                      alert.addAction(action)
                      self.present(alert, animated: true, completion: nil)
        }
        carritoViewModel.GetAll()
        
    }
}
