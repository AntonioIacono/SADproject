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
        orders.get(use: getAllHandler)
        orders.get(":id",use: getHandler)
        orders.get(":id","ingredients", use: getDrinksHandler)
        orders.post(use: createHandler)
        orders.post(":order_id","drinks",":drink_id",use: addDrinkHandler)
        orders.put(":id",use: updateHandler)
        orders.delete(":id", use: deleteHandler)
        orders.delete(":order_id","drinks",":drink_id",use: deleteDrinkHandler)
        
    }
    
    //POST
    func createHandler(_ req:Request)throws ->EventLoopFuture<Order> {
        let data = try req.content.decode(CreateOrderData.self)
        let order = Order(state: data.state,total: data.total,bill: data.bill)
        return order.save(on: req.db).map { order }
    }
    
    //GET
    func getHandler(_ req:Request)->EventLoopFuture<Order> {
        Order.find(req.parameters.get("id"), on: req.db).unwrap(or:Abort(.notFound))}
    
    //GET ALL
    func getAllHandler(req: Request) throws -> EventLoopFuture<[Order]> {
        return Order.query(on: req.db).all()
    }
    
    //PUT
    func updateHandler(_ req:Request)throws ->EventLoopFuture<Order> {
        let updateData = try req.content.decode(CreateOrderData.self)
        return Order.find(req.parameters.get("id"), on: req.db).unwrap(or:Abort(.notFound)).flatMap { order in
            order.state = updateData.state
            order.total = updateData.total
            order.$bill.id = updateData.bill
            return order.save(on: req.db).map {order}}
    }
    
    //DELETE
    func deleteHandler(_ req:Request)->EventLoopFuture<HTTPStatus> {
        Order.find(req.parameters.get("id"), on: req.db).unwrap(or:Abort(.notFound)).flatMap { order in
            order.delete(on: req.db).transform(to: .noContent)}
    }
    
    //POST DRINK DELL' ORDINE
    func addDrinkHandler(_ req:Request)->EventLoopFuture<HTTPStatus> {
        let orderQuery = Order.find(req.parameters.get("order_id"), on: req.db).unwrap(or:Abort(.notFound))
        let drinkQuery = Drink.find(req.parameters.get("drink_id"), on: req.db).unwrap(or:Abort(.notFound))
        return orderQuery.and(drinkQuery).flatMap { order, drink in order.$drink.attach(drink, on: req.db).transform(to: .created)}
    }
    
    //GET DRINK DELL' ORDINE
    func getDrinksHandler(_ req:Request)->EventLoopFuture<[Drink]> {
        Order.find(req.parameters.get("id"), on: req.db).unwrap(or:Abort(.notFound)).flatMap { order in
            order.$drink.query(on: req.db).all()}
    }
    
    //DELETE DRINK DELL' ORDINE
    func deleteDrinkHandler(_ req:Request)->EventLoopFuture<HTTPStatus> {
        let orderQuery = Order.find(req.parameters.get("order_id"), on: req.db).unwrap(or:Abort(.notFound))
        let drinkQuery = Drink.find(req.parameters.get("drink_id"), on: req.db).unwrap(or:Abort(.notFound))
        return orderQuery.and(drinkQuery).flatMap { order, drink in order.$drink.detach(drink, on: req.db).transform(to: .noContent)}
    }
    
    // GET CONTO DELL'ORDINE
    func getBillHandler(_ req:Request)->EventLoopFuture<Bill> {
         Order.find(req.parameters.get("id"), on: req.db).unwrap(or:Abort(.notFound)).flatMap { order in  order.$bill.get(on: req.db)}}
}

struct CreateOrderData: Content {
    let state: String
    let bill: UUID
    let total: Double
}
