//
//  Producto.swift
//  JMontesEccomerceVenta
//
//  Created by Admin on 25/05/23.
//

import Foundation
import SQLite3

class Producto{  //Modelo
    
    //Propiedades
    var IdProducto : Int? = nil
    var Imagen :  String? = nil
    var Nombre :  String? = nil
    var Precio :  String? = nil
    var Descripcion :  String? = nil
    
    //Propìedad de navegacion
    var Departamento : Departamento? = nil
}
