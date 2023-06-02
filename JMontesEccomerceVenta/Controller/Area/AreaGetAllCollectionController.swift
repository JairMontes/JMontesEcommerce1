//
//  AreaGetAllCollectionController.swift
//  JMontesEccomerceVenta
//
//  Created by Admin on 25/05/23.
//

import UIKit

class AreaGetAllCollectionController: UIViewController {
    
    @IBOutlet weak var txtProducto: UITextField!
    //@IBOutlet weak var AreaCollection1: UICollectionView!
    @IBOutlet weak var AreaCollection1: UICollectionView!
    
 var area : [Area] = []
 var IdArea : Int = 0
 var Id : Int = 0
 var guardardato : String = ""
 
 override func viewDidLoad() {
     super.viewDidLoad()
     
     AreaCollection1.delegate = self
     AreaCollection1.dataSource = self
     
     AreaCollection1.register(UINib(nibName: "AreaCollectionCell", bundle: .main), forCellWithReuseIdentifier:"Cell")
     
     updateUI()
 }


    @IBAction func btnSearch(_ sender: UIButton) {
    
    
            guard txtProducto.text != "" else {
                //ddletiqueta.text =  "El campo no puede ser vacio"
                txtProducto.layer.borderColor = UIColor.red.cgColor
                txtProducto.layer.borderWidth = 2
                return
            }
            guardardato = txtProducto.text!
            
            self.performSegue(withIdentifier: "segueProductoArea", sender: self)    }
        
        

    }




extension AreaGetAllCollectionController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        //self.area.count
        // print(area.count)
         return area.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AreaCollectionCell
        
        cell.lblNombre.text = area[indexPath.row].Nombre
        cell.Imageview.image = UIImage(named: "\(area[indexPath.row].Nombre!)")
         
        
        
        return cell
    }
    
    
    
    func updateUI(){
            var result = AreaViewModel.GetAllArea()
            area.removeAll()
            if result.Correct!{
                for objarea in result.Objects!{
                    let resultado = objarea as! Area //Unboxing
                    area.append(resultado)
                }
                AreaCollection1.reloadData()
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           Id = area[indexPath.row].IdArea!
           print(Id)
           self.performSegue(withIdentifier: "DepartamentoFormController", sender: self)
           }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              //controlar que hacer antes de ir a la siguiente vista
              if segue.identifier == "DepartamentoFormController"{
                  let formControl = segue.destination as! DepartamentoGetAllCollectionController
                  formControl.IdArea = self.Id
                  
              }else{
                  let formcontrol1 = segue.destination as! ProductoGetAllCollectionController
                  formcontrol1.datotxt = guardardato
              }
          }
}
