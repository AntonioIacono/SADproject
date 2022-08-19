//
//  IngredientController.swift
//  
//
//  Created by Vincenzo on 19/08/22.
//

import Fluent
import Vapor

struct IngredientController: RouteCollection {
	func boot(routes: RoutesBuilder) throws {
		let ingredients = routes.grouped("ingredients")
		ingredients.get(use: index)
	}
	
	// /drink route
	func index(req: Request) throws -> EventLoopFuture<[Ingredient]> {
		return Ingredient.query(on: req.db).all()
	}
}
