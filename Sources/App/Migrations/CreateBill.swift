//
//  File.swift
//  
//
//  Created by Antonio Iacono on 18/08/22.
//

import Foundation
import Fluent

struct CreateBill: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("bills")
            .id()
            .field("table", .int, .required)
//            .field("order_id", .uuid, .required, .references("orders","id"))
//            .unique(on: "order_id")
            .field("state", .string, .required)
            .field("date", .date, .required)
            .field("total", .double, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("bills").delete()
    }
}
