//
//  DepartamentoGetAllCollectionController.swift
//  JMontesEccomerceVenta
//
//  Created by Admin on 25/05/23.
//

import UIKit

class DepartamentoGetAllCollectionController: UICollectionViewController {
    
    var departamento : [Departamento] = []
    var IdArea : Int = 0
    var Id : Int = 0
    
    
   
    
    @IBOutlet var DepartamentoCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Register cell classes
        collectionView.register(UINib(nibName: "AreaCollectionCell", bundle: .main), forCellWithReuseIdentifier:"Cell")
        
        DepartamentoCollection.delegate = self
        DepartamentoCollection.dataSource = self
        updateUI()
                
        print("el area es: \(IdArea)")
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return departamento.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AreaCollectionCell
        
          cell.lblNombre.text = departamento[indexPath.row].Nombre
          cell.Imageview.image = UIImage(named: "\(departamento[indexPath.row].Nombre!)")
    
        return cell
    }


override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       Id  = departamento[indexPath.row].IdDepartamento!
       print(Id)

       self.performSegue(withIdentifier: "SegueProducto", sender: self)
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       //controlar que hacer antes de ir a la siguiente vista
       if segue.identifier == "SegueProducto"{
           let formControl = segue.destination as! ProductoGetAllCollectionController
           formControl.IdDepartamento = Id
           
       }
   }


   func updateUI(){
       var result = DepartamentoViewModel.GetByIdArea(IdArea: IdArea)
       departamento.removeAll()
       if result.Correct!{
           for objdepartamento in result.Objects!{
               let resultado = objdepartamento as! Departamento
               //Unboxing
               departamento.append(resultado)
           }
           collectionView?.reloadData()
       }
   }
}
