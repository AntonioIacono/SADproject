//
//  File.swift
//  
//
//  Created by Antonio Iacono on 19/08/22.
//

import Foundation
import Fluent

struct CreateRecipe: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("recipes")
            .field("ingredient_id", .uuid, .required, .references("orders","id"))
            .field("drink_id", .uuid, .required, .references("drinks","id"))
            .unique(on: "ingredient_id","drink_id")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("recipes").delete()
    }
}
