//
//  File.swift
//  
//
//  Created by Antonio Iacono on 19/08/22.
//

import Foundation
import Fluent

struct CreateIngredients: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("ingredients")
            .id()
            .field("name", .string, .required)
            .field("producer", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("ingredients").delete()
    }
}
