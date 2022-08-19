//
//  File.swift
//  
//
//  Created by Antonio Iacono on 18/08/22.
//

//import Foundation
//import Fluent
//
//struct CreateOrdination: Migration {
//    
//    func prepare(on database: Database) -> EventLoopFuture<Void> {
//        return database.schema("ordination")
//            .field("idBill", .uuid, .required, .references("Bill","id"))
//            .field("idOrder", .uuid, .required, .references("Order","id"),.identifier(auto: true))
//            .field("total", .double, .required)
//            .create()
//    }
//    
//    func revert(on database: Database) -> EventLoopFuture<Void> {
//        return database.schema("ordination").delete()
//    }
//}
