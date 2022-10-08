//
//  Order.swift
//  
//
//  Created by Antonio Iacono on 18/08/22.
//

import Foundation
import  Fluent
import Vapor

final class Order: Model, Content {
    static let schema = "orders"
    
    @ID(key: .id)
    var id: UUID?
    @Field(key: "state")
    var state: String
    @Parent(key: "bill_id")
    var bill : Bill
    @Siblings(through: SubOrder.self, from: \.$order, to: \.$drink)
    var drink: [Drink]
    @Field(key: "total")
    var total: Double
    
    init() {}
    
    init(id: UUID? = nil, state: String, total: Double, bill: Bill.IDValue){
        self.id = id
        self.state = state
        self.total = total
        self.$bill.id = bill
    }
}
