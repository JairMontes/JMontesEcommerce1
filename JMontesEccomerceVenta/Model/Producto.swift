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
    var Precio :  Int? = nil
    var Descripcion :  String? = nil
    
    //Propiedad de navegación
    var Departamento : Departamento? = nil
}
