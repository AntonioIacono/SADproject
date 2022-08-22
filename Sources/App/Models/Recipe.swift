//
//  Recipe.swift
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
  
    @ID
    var id: UUID?
    @Parent(key: "ingredient_id")
    var ingredient: Ingredient
    @Parent(key: "drink_id")
    var drink: Drink
   
    init() {}
    
    init(id: UUID? = nil, order: Ingredient, drink: Drink) throws{
        self.id = id
        self.$ingredient.id = try ingredient.requireID()
        self.$drink.id = try drink.requireID()
    }
}

