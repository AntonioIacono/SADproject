//
//  CreateDrink.swift
//  
//
//  Created by Antonio Iacono on 17/08/22.
//

import Foundation
import Fluent

struct CreateDrink: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("drinks")
            .id()
            .field("name", .string, .required)
            .field("description", .double, .required)
            .field("price", .string, .required)
            .field("availability", .bool, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("drinks").delete()
    }
}
