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
    static let schema = "order"
    
    @ID(key: .id)
    var id: UUID?
    @Field(key: "state")
    var state: String

    
    init() {}
    
    init(id: UUID? = nil , state: String){
        self.id = id
        self.state = state
    }
}
