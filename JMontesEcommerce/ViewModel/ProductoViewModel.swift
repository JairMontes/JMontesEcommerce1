//
//  ProductoViewModel.swift
//  JMontesEcommerce
//
//  Created by Admin on 16/05/23.
//

import Foundation
import SQLite3

class ProductoViewModel{
    
    //ADD
    static func Add(producto: Producto) -> Result{
        var result = Result()
        var context = DBManager()
        var statement : OpaquePointer? = nil
        var query = "INSERT INTO Producto(Imagen,Nombre,Precio,Descripcion,IdDepartamento) VALUES (?,?,?,?,?)"
        do{
            if(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
                
                sqlite3_bind_text(statement,1, (producto.Imagen as! NSString).utf8String , -1 , nil)
                sqlite3_bind_text(statement,2, (producto.Nombre as! NSString).utf8String , -1 , nil)
                sqlite3_bind_text(statement,3, (producto.Precio as! NSString).utf8String , -1 , nil)
                sqlite3_bind_text(statement,4, (producto.Descripcion as! NSString).utf8String , -1 , nil)
                sqlite3_bind_int64(statement,5, sqlite3_int64((producto.Departamento?.IdDepartamento) as! NSNumber))
                                
               
                
                if(sqlite3_step(statement) == SQLITE_DONE){
                                    print("Producto insertado")
                                    result.Correct = true
                                    
                                }else{
                                    result.ErrorMessage = "no se agrego"
                                }
                                
                            }else{
                                result.Correct = false
                                result.ErrorMessage = "ocurrio un error"
                            }
                        }catch let ex{
                            result.Correct = false
                            result.ErrorMessage = ex.localizedDescription //Ex.Message
                            result.Ex = ex
                        }
                        sqlite3_finalize(statement)
                        sqlite3_close(context.db)
                        return result
                    }
                    
    
    //UPDATE
    static func Update(producto: Producto) -> Result
    {
        var result = Result()
        var context = DBManager()
        var statement : OpaquePointer? = nil
        var query = "UPDATE Producto SET  Imagen= ?, Nombre = ?, Precio= ?, Descripcion= ?, IdDepartamento = ? WHERE IdProducto = \(producto.IdProducto!)"
        
        do{
            if(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
                
                sqlite3_bind_text(statement,1, (producto.Imagen as! NSString).utf8String , -1 , nil)
                sqlite3_bind_text(statement,2, (producto.Nombre as! NSString).utf8String , -1 , nil)
                sqlite3_bind_text(statement,3, (producto.Precio as! NSString).utf8String , -1 , nil)
                sqlite3_bind_text(statement,4, (producto.Descripcion as! NSString).utf8String , -1 , nil)
                sqlite3_bind_int64(statement,5, sqlite3_int64((producto.Departamento?.IdDepartamento) as! NSNumber))
                
                if(sqlite3_step(statement) == SQLITE_DONE){
                    print("Producto actualizado")
                    result.Correct = true
                }else{
                    result.ErrorMessage = "Error al actualizar"
                }
                
            }else{
                result.Correct = false
                result.ErrorMessage = "ocurrio un error"
            }
        }catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription //Ex.Message
            result.Ex = ex
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    //DELETE
    static func Delete(IdProducto : Int ) -> Result {
        var context = DBManager()
        var result = Result()
        var statement : OpaquePointer? = nil
        var query = "DELETE FROM Producto WHERE IdProducto = \(IdProducto)"
        do {
            if try (sqlite3_prepare_v2(context.db, query, -1, &statement, nil)) == SQLITE_OK {
                if sqlite3_step(statement) == SQLITE_DONE{
                    print("Producto eliminado")
                    result.Correct = true
                }else{
                    result.ErrorMessage = "Error al eliminar"
                }
            }else{
                result.Correct = false
                result.ErrorMessage = "ocurrio un error"
            }
        }catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription //Ex.Message
            result.Ex = ex
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
   
    //GETALL
    static func GetAll() -> Result{
        var context = DBManager()
        var result = Result()
        let query = "SELECT producto.IdProducto,producto.Imagen,producto.Nombre,producto.Precio,producto.Descripcion,departamento.IdDepartamento,departamento.Nombre FROM Producto  INNER JOIN Departamento  ON Producto.IdDepartamento = Departamento.IdDepartamento"
        var statement : OpaquePointer?
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while try sqlite3_step(statement) == SQLITE_ROW {
                    var producto = Producto()
                    producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                    producto.Imagen = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    producto.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                    producto.Precio = Int(sqlite3_column_int(statement, 3))
                    producto.Descripcion = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                  
                    producto.Departamento = Departamento()
                    producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 5))
                   producto.Departamento?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 6)))
                result.Objects?.append(producto)
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
      
    //GETBYID
    static func GetById(IdProducto : Int) -> Result{
        var context = DBManager()
        var result = Result()
        let query = "SELECT producto.IdProducto,producto.Imagen,producto.Nombre,producto.Precio,producto.Descripcion,departamento.IdDepartamento,departamento.Nombre FROM Producto  INNER JOIN Departamento  ON Producto.IdDepartamento = Departamento.IdDepartamento WHERE IdProducto = \(IdProducto)"
        var statement : OpaquePointer?
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                if try sqlite3_step(statement) == SQLITE_ROW {
                    var producto = Producto()
                    producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                    producto.Imagen = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    producto.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                    producto.Precio = Int(sqlite3_column_int(statement, 3))
                    producto.Descripcion = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                                    
                    producto.Departamento = Departamento()
                    producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 5))
                    producto.Departamento?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 6)))
                    result.Objects?.append(producto)
                            
                            result.Object = producto
                    
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
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    static func GetByNombre(Sentencia : String) -> Result{
            var context = DBManager()
            var result = Result()
            let query = "select IdProducto, Nombre, Precio, Descripcion, Imagen From Producto where Nombre LIKE '%\(Sentencia)%'"
            var statement : OpaquePointer?
            do{
                if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                    result.Objects = []
                    while try sqlite3_step(statement) == SQLITE_ROW {
                        var producto = Producto()
                        producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                        producto.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                        producto.Precio = Int(sqlite3_column_int(statement, 2))
                        producto.Descripcion = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                        producto.Imagen = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                        
                        result.Objects?.append(producto)
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
            sqlite3_finalize(statement)
            sqlite3_close(context.db)
            return result
        }
    
    static func GetByIdDepartamento(IdDepartamento : Int) -> Result{
            var context = DBManager()
            var result = Result()
            let query = "select IdProducto, Nombre, Precio, Descripcion, Imagen From Producto where IdDepartamento = \(IdDepartamento)"
            var statement : OpaquePointer?
            do{
                if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                    result.Objects = []
                    while try sqlite3_step(statement) == SQLITE_ROW {
                        var producto = Producto()
                        producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                        producto.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                        producto.Precio = Int(sqlite3_column_int(statement, 2))
                        producto.Descripcion = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                        producto.Imagen = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                        
                        result.Objects?.append(producto)
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
            sqlite3_finalize(statement)
            sqlite3_close(context.db)
            return result
        }

        
    }




   

