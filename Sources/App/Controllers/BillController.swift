//
//  BillController.swift
//  
//
//  Created by Vincenzo on 19/08/22.
//

import Fluent
import Vapor

struct BillController: RouteCollection {
	func boot(routes: RoutesBuilder) throws {
		let bills = routes.grouped("bills")
		bills.get(use: index)
	}
	
	func index(req: Request) throws -> EventLoopFuture<[Bill]> {
		return Bill.query(on: req.db).all()
	}
}
