//
//  File.swift
//  
//
//  Created by Antonio Iacono on 18/08/22.
//

import Foundation
import Fluent

struct CreateComposition: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("composition")
            .field("idOrder", .uuid, .required, .references("Order","id"), .identifier(auto: true))
            .field("idDrink", .uuid, .required, .references("Drink","id"))

            .field("description", .string, .required)
            .field("description2", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("composition").delete()
    }
}
