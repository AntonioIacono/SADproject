//
//  File.swift
//  
//
//  Created by Antonio Iacono on 18/08/22.
//

import Foundation
import  Fluent
import Vapor
import AppKit

final class Composition: Model, Content {
    var id: UUID?
    static let schema = "composition"
    
    @Field(key: "idOrder")
    var idOrder: UUID?
    @Field(key: "idDrink")
    var idDrink: UUID?
   
    init() {}
    
    init(idOrder: UUID? = nil , idDrink: UUID? = nil ){
        self.idOrder = idOrder
        self.idDrink = idDrink
    }
}

