//
//  OrderController.swift
//  
//
//  Created by Antonio Iacono on 18/08/22.
//

import Fluent
import Vapor

struct OrderController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let orders = routes.grouped("orders")
        orders.get(use: index)
    }
    
    // /drink route
    func index(req: Request) throws -> EventLoopFuture<[Order]> {
        return Order.query(on: req.db).all()
    }
}
