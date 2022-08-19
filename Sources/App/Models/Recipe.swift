//
//  File.swift
//  
//
//  Created by Antonio Iacono on 19/08/22.
//

import Foundation
import  Fluent
import Vapor
import AppKit

final class Recipe: Model, Content {
    
    static let schema = "recipes"
    
  
    var id: UUID?
    @Parent(key: "ingredient_id")
    var ingredient: Ingredient
    @Parent(key: "drink_id")
    var drink: Drink
   
    init() {}
    
    init(order: Ingredient.IDValue , drink: Drink.IDValue) throws{
        self.$ingredient.id = order
        self.$drink.id = drink
    }
}

