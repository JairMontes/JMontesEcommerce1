//
//  CarritoViewModel.swift
//  JMontesEccomerceVenta
//
//  Created by Admin on 26/05/23.
//

import Foundation
import UIKit
import CoreData

class CarritoViewModel{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func Add(_ IdProducto : Int) -> Result{
        var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "VentaProducto", in: context)!
        
        let producto = NSManagedObject(entity: entity, insertInto: context)
        
        producto.setValue(IdProducto, forKey: "idProducto")
        producto.setValue(1, forKey: "cantidad")
        
        do{
            try context.save()
            result.Correct = true
        }
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        
        return result
    }
    func Update(IdProducto : Int, cantidad : Int) -> Result{
           
           var result = Result()
        
        var ventasproductos = VentaProductos()
        
           let context = appDelegate.persistentContainer.viewContext
           
        let response : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "VentaProducto")
           
           response.predicate = NSPredicate(format: "idProducto = \(IdProducto)")
        do{
            let test = try context.fetch(response)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(cantidad, forKey: "cantidad")
            do{
                try context.save()
                result.Correct = true
            }catch let error{
                result.Correct = false
                result.ErrorMessage = error.localizedDescription
                result.Ex = error               }
        }catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        return result
       }
    
    func Delete(IdProducto : Int) -> Result{
      var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        
        let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
        
        response.predicate = NSPredicate(format: "idProducto = \( IdProducto)")
        
        do{
            let test = try context.fetch(response)
            
            let objectToDelete = test[0] as! NSManagedObject
            context.delete(objectToDelete)
            do{
                try context.save()
               result.Correct = true
                //result.Correct = false
            }catch let error{
                result.Correct = false
                result.ErrorMessage = error.localizedDescription
                result.Ex = error               }
        }catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        return result
    }
    func GetById(IdProducto : Int) -> Result{
        var result = Result()
        let context = appDelegate.persistentContainer.viewContext
        let response = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
        
        //let predicate = NSPredicate(format: "idProducto = %@", String(IdProducto))
        
        let predicate = NSPredicate(format: "idProducto = %i", IdProducto)
        
        response.predicate = predicate
        do{
            let resolve = try context.fetch(response)
            let obj = resolve.first as! NSManagedObject
            print(obj.objectID)
            print(obj.value(forKey: "cantidad") as Any)
            result.Correct = true
        }
        catch let error{
            print(error.localizedDescription)
            result.Correct = false
        }
        return result
    }
    func GetAll() -> Result{
        var result = Result()
                   
                   let context = appDelegate.persistentContainer.viewContext
                   
                   let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
                   
                   do{
                       result.Objects = []
                       let resultFetch = try context.fetch(response)
                       for obj in resultFetch as! [NSManagedObject]{
                           //Instancia de venta producto //Crear Modelo
                           let modeloventaproducto = VentaProductos()
                           
                           modeloventaproducto.producto = Producto()
                           
                           modeloventaproducto.producto?.IdProducto =  obj.value(forKey: "idProducto") as! Int
                           modeloventaproducto.cantidad = obj.value(forKey: "cantidad") as! Int
                        
                           let result1 = ProductoViewModel.GetById(IdProducto: modeloventaproducto.producto?.IdProducto as! Int)
                           if result1.Correct!{
                               let producto = result1.Object! as! Producto
                               
                               modeloventaproducto.producto?.Nombre = producto.Nombre
                               modeloventaproducto.producto?.Imagen = producto.Imagen
                           }
                         
                           result.Objects?.append(modeloventaproducto)
                          
                       }
                       result.Correct = true
                   }
                   catch let error {
                       result.Correct = false
                       result.ErrorMessage = error.localizedDescription
                       result.Ex = error
                   }
                   
                   return result
               }
        }

static func GetAllPago() -> Result{
    var context = DBManager()
    var result = Result()
    let query = "SELECT IdPago,Nombre FROM Pago"
    var statement : OpaquePointer?
    do{
        if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
            result.Objects = []
            while try sqlite3_step(statement) == SQLITE_ROW {
                var pago = Pago()
                pago.IdPago = Int(sqlite3_column_int(statement, 0))
                pago.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
             
            result.Objects?.append(pago)
            }
            result.Correct = true
        }else  {
            result.Correct = false
            result.ErrorMessage = "Ocurrio un error"
        }
    }
    catch let ex{
        result.Correct = false
        result.ErrorMessage = ex.localizedDescription //Ex.Message
        result.Ex = ex
    }
    return result
}
