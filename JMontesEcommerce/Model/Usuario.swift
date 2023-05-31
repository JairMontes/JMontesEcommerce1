//
//  Usuario.swift
//  JMontesEcommerce
//
//  Created by Admin on 02/05/23.
//

import Foundation
import SQLite3

class Usuario{  //Modelo
    
    //Propiedades
    var IdUsuario : Int? = nil
    var Nombre :  String? = nil
    var ApellidoPaterno :  String? = nil
    var ApellidoMaterno :  String? = nil
    var Username :  String? = nil
    var FechaNacimiento :  String? = nil
    var Password :  String? = nil
    
    //Propìedad de navegacion
    var Rol : Rol? = nil
}
