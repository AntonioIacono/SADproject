//
//  Drink.swift
//  
//
//  Created by Antonio Iacono on 17/08/22.
//

import Foundation
import  Fluent
import Vapor
import AppKit

final class Drink: Model, Content {
    static let schema = "drinks"
    
    @ID(key: .id)
    var id: UUID?
    @Field(key: "name")
    var name: String
    @Field(key: "description")
    var description: String
    @Field(key: "price")
    var price: Double
    @Field(key: "availability")
    var availability : Bool
//    @Siblings(through: SubOrder.self, from: \.$drink, to: \.$order)
//    public var order: [Order]
    @Siblings(through: Recipe.self, from: \.$drink, to: \.$ingredient)
    public var ingredient: [Ingredient]
    
    
    init() {}
    
    init(id: UUID? = nil, name: String, description: String, price: Double, availability: Bool){
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.availability = availability
    }
}
