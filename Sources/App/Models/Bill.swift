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

final class Bill: Model, Content {
    static let schema = "bill"
    
    @ID(key: .id)
    var id: UUID?
    @Field(key: "table")
    var table: Int
    @Field(key: "state")
    var state: String
    @Field(key: "date")
    var date: Date
    @Field(key: "total")
    var total: Double
    
    init() {}
    
    init(id: UUID? = nil , table: Int, state: String, date: Date, total : Double){
        self.id = id
        self.table = table
        self.state = state
        self.date = date
        self.total = total
    }
}
