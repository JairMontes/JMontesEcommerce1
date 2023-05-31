//
//  AreaViewModel.swift
//  JMontesEcommerce
//
//  Created by Admin on 18/05/23.
//

import Foundation
import SQLite3

class AreaViewModel{
    
    //GETALL AREA
    static func GetAllArea() -> Result{
        var context = DBManager()
        var result = Result()
        let query = "SELECT IdArea,Nombre FROM Area"
        var statement : OpaquePointer?
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while try sqlite3_step(statement) == SQLITE_ROW {
                    var area = Area()
                    area.IdArea = Int(sqlite3_column_int(statement, 0))
                    area.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    result.Objects?.append(area)
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
    
    
}
