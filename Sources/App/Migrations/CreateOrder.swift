//
//  File.swift
//  
//
//  Created by Antonio Iacono on 18/08/22.
//

import Foundation
import Fluent

struct CreateOrder: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("order")
            .id()
            .field("state", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("order").delete()
    }
}
