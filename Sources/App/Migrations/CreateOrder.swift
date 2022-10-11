//
//  CreateOrder.swift
//  
//
//  Created by Antonio Iacono on 18/08/22.
//

import Foundation
import Fluent

struct CreateOrder: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("orders")
            .id()
            .field("state", .string, .required)
            .field("bill_id", .uuid, .required,.references("bills", "id"))
            .field("total", .double, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("orders").delete()
    }
}


