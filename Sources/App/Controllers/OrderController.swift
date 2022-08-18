//
//  File.swift
//  
//
//  Created by Antonio Iacono on 18/08/22.
//

import Fluent
import Vapor

struct OrderController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let drink = routes.grouped("order")
        drink.get(use: index)
    }
    
    // /drink route
    func index(req: Request) throws -> EventLoopFuture<[Drink]> {
        return Drink.query(on: req.db).all()
    }
}
