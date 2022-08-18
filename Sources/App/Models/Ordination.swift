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
import PostgresNIO

final class Ordination: Model, Content {
    var id: UUID?
 
    static let schema = "ordination"
    
    @Field(key: "idBill")
    var idBill: UUID?
    @Field(key: "idOrder")
    var idOrder: UUID?
    @Field(key: "total")
    var total: Double
    
    
    init() {}
    
    init(idBill: UUID? = nil , idOrder: UUID? = nil, total: Double ){
        self.idBill = idBill
        self.idOrder = idOrder
        self.total = total
    }
}
