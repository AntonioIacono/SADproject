//
//  File.swift
//  
//
//  Created by Antonio Iacono on 18/08/22.
//

import Foundation
import  Fluent
import Vapor
import AppKit

final class SubOrder: Model, Content {
    
    static let schema = "sub_orders"
    
  
    var id: UUID?
    @Parent(key: "order_id")
    var order: Order
    @Parent(key: "drink_id")
    var drink: Drink
    
    @Field(key: "amount")
    var amount: Int
   
    init() {}
    
    init(order: Order.IDValue , drink: Drink.IDValue ,amount: Int){
        
        self.$order.id = order
        self.$drink.id = drink
        self.amount = amount
    }
}

