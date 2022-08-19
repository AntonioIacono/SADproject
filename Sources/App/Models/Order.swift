//
//  Order.swift
//  
//
//  Created by Antonio Iacono on 18/08/22.
//

import Foundation
import  Fluent
import Vapor
import AppKit

final class Order: Model, Content {
    static let schema = "orders"
    
    @ID(key: .id)
    var id: UUID?
    @Field(key: "state")
    var state: String
    @Parent(key: "bill_id")
    var bill : Bill
    @Siblings(through: SubOrder.self, from: \.$order, to: \.$drink)
    public var drink: [Drink]
    
    init() {}
    
    init(id: UUID? = nil, state: String){
        self.id = id
        self.state = state
    }
}
