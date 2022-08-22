//
//  CreateRecipe.swift
//  
//
//  Created by Antonio Iacono on 19/08/22.
//

import Foundation
import Fluent

struct CreateRecipe: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("recipes")
            .id()
            .field("ingredient_id", .uuid, .required, .references("ingredients", "id",onDelete: .cascade))
            .field("drink_id", .uuid, .required, .references("drinks", "id", onDelete: .cascade))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("recipes").delete()
    }
}
