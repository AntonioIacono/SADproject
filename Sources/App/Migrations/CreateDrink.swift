//
//  File.swift
//  
//
//  Created by Antonio Iacono on 17/08/22.
//

import Foundation
import Fluent

struct CreateDrink: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("drink")
            .id()
            .field("name", .string, .required)
            .field("description", .string, .required)
            .field("description2", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("drink").delete()
    }
}
