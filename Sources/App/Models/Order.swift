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

final class Order: Model, Content {
    static let schema = "orders"
    
    @ID(key: .id)
    var id: UUID?
    @Field(key: "state")
    var state: String
    @Children(for: \.$order)
    var subOrders : [SubOrder]

    
    init() {}
    
    init(id: UUID? = nil , state: String, subOrders : [SubOrder]){
        self.id = id
        self.state = state
        self.subOrders = subOrders
    }
}
