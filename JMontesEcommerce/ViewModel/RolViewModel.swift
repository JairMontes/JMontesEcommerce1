//
//  UsuarioViewModel.swift
//  JMontesEcommerce
//
//  Created by Admin on 04/05/23.
//

import Foundation
import SQLite3

class RolViewModel{
    //metodos
    //ADD
    static func Add(rol: Rol) -> Result{
        var result = Result()
        var context = DBManager()
        var statement : OpaquePointer? = nil
        var query = "INSERT INTO Rol(Nombre) VALUES (?)"
        do{
            if(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
                
                sqlite3_bind_text(statement,1, (rol.Nombre as! NSString).utf8String , -1 , nil)
                
                if(sqlite3_step(statement) == SQLITE_DONE){
                                                   print("Rol insertado correctamente")
                                                   result.Correct = true
                                                   
                                               }else{
                                                   result.ErrorMessage = "No se pudo insertar el rol"
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
    static func Update(rol: Rol) -> Result
    {
        var result = Result()
        var context = DBManager()
        var statement : OpaquePointer? = nil
        var query = "UPDATE Usuario SET Nombre = ? WHERE IdRol = \(rol.IdRol!)"
        
        do{
            if(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
                
                
                sqlite3_bind_text(statement,1, (rol.Nombre as! NSString).utf8String , -1 , nil)
                
                
                if(sqlite3_step(statement) == SQLITE_DONE){
                    print("Rol actualizado")
                    result.Correct = true
                }else{
                    result.ErrorMessage = "no se actualizó"
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
    static func Delete(IdRol : Int ) -> Result {
        var context = DBManager()
        var result = Result()
        var statement : OpaquePointer? = nil
        var query = "DELETE FROM Rol WHERE IdRol = \(IdRol)"
        do {
            if try (sqlite3_prepare_v2(context.db, query, -1, &statement, nil)) == SQLITE_OK {
                if sqlite3_step(statement) == SQLITE_DONE{
                    print("rol eliminado")
                    result.Correct = true
                }else{
                    result.ErrorMessage = "no se elimino"
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
        let query = "SELECT IdRol,Nombre FROM Rol"
        var statement : OpaquePointer?
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while try sqlite3_step(statement) == SQLITE_ROW {
                    var rol = Rol()
                    rol.IdRol = Int(sqlite3_column_int(statement, 0))
                    rol.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    result.Objects?.append(rol)
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
    static func GetById(IdRol : Int) -> Result{
        var context = DBManager()
        var result = Result()
        let query = "SELECT IdRol, Nombre FROM Rol WHERE IdRol = \(IdRol)"
        var statement : OpaquePointer?
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                if try sqlite3_step(statement) == SQLITE_ROW {
                    var rol = Rol()
                    rol.IdRol = Int(sqlite3_column_int(statement, 0))
                    rol.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    result.Object = rol
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
