//
//  Ingredient.swift
//  
//
//  Created by Antonio Iacono on 19/08/22.
//

import Foundation
import Foundation
import  Fluent
import Vapor
import AppKit

final class Ingredient: Model, Content {
    static let schema = "ingredients"
	
    @ID(key: .id)
    var id: UUID?
    @Field(key: "name")
    var name: String
    @Field(key: "producer")
    var producer: String
    @Siblings(through: Recipe.self, from: \.$ingredient, to: \.$drink)
    public var drinks: [Drink]

    init() {}
    
    init(id: UUID? = nil, name: String, producer: String){
        self.id = id
        self.name = name
        self.producer = producer
    }
}
