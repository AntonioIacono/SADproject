//
//  CreateSubOrder.swift
//  
//
//  Created by Antonio Iacono on 18/08/22.
//

import Foundation
import Fluent

struct CreateSubOrder: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("sub_orders")
            .field("order_id", .uuid, .required, .references("orders", "id"))
            .field("drink_id", .uuid, .required, .references("drinks", "id"))
            .field("amount", .int , .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("sub_orders").delete()
    }
}





//struct CreateSubOrder: Migration {
//    
//    func prepare(on database: Database) -> EventLoopFuture<Void> {
//        return database.schema("sub_order")
//            .field("order", .int, .required, .references("Order","id"), .identifier(auto: true))
//            .field("drink", .uuid, .required, .references("Drink","id"))
//
//            .field("description", .string, .required)
//            .field("description2", .string, .required)
//            .create()
//    }
//    
//    func revert(on database: Database) -> EventLoopFuture<Void> {
//        return database.schema("composition").delete()
//    }
//}
