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
        return database.schema("bill")
            .id()
            .field("table", .int, .required)
            .field("state", .string, .required)
            .field("date", .date, .required)
            .field("total", .double, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("bill").delete()
    }
}
