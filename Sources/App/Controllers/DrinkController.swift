//
//  DrinkController.swift
//  
//
//  Created by Antonio Iacono on 17/08/22.
//

import Fluent
import Vapor

struct DrinkController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let drinks = routes.grouped("drinks")
        drinks.get(use: index)
    }
    
    // /drink route
    func index(req: Request) throws -> EventLoopFuture<[Drink]> {
        return Drink.query(on: req.db).all()
    }
}
