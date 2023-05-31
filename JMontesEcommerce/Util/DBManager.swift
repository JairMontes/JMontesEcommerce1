//
//  DBManager.swift
//  JMontesEcommerce
//
//  Created by Admin on 02/05/23.
//

import Foundation
import SQLite3

class DBManager {

    var db : OpaquePointer?  //0x0000000
    let path : String = "Document.JMontesEcommerce.sqlite"
    
    init(){
        self.db = Get()
    }
    
 
    func Get() -> OpaquePointer?{
        let filePathCompartido = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.JMontesEcommerce")!.appendingPathComponent(path)
        print("FilePath:")
        print(filePathCompartido)
        
        let filePath = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(path)
        
        
        if(sqlite3_open(filePathCompartido.path, &db) == SQLITE_OK){
            print("Conexion exitosa")
            print(filePath)
            return db
        }else{
            print("Fallo la conexión")
            return nil
        }
    }
}
