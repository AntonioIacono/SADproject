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
        bills.get(use: getAllHandler)
        bills.get(":id",use: getHandler)
        bills.get(":id","drinks", use: getOrderHandler)
        bills.post(use: createHandler)
        bills.put(":id",use: updateHandler)
        bills.delete(":id", use: deleteHandler)
    }
    
    //POST
    func createHandler(_ req:Request)throws ->EventLoopFuture<Bill> {
        let bill = try req.content.decode(Bill.self)
        return bill.save(on: req.db).map { bill }
    }
    
    //GET
    func getHandler(_ req:Request)->EventLoopFuture<Bill> {
        Bill.find(req.parameters.get("id"), on: req.db).unwrap(or:Abort(.notFound))}
    
    //GET ALL
    func getAllHandler(req: Request) throws -> EventLoopFuture<[Bill]> {
        return Bill.query(on: req.db).all()
    }
    
    //PUT
    func updateHandler(_ req:Request)throws ->EventLoopFuture<Bill> {
        let updatedBill = try req.content.decode(Bill.self)
        return Bill.find(req.parameters.get("id"),on: req.db).unwrap(or:Abort(.notFound)).flatMap { bill in
            bill.table = updatedBill.table
            bill.state = updatedBill.state
            bill.total = updatedBill.total
            bill.date = updatedBill.date
            return bill.save(on: req.db).map {bill}}
    }
    
    //DELETE
    func deleteHandler(_ req:Request)->EventLoopFuture<HTTPStatus> {
        Bill.find(req.parameters.get("id"), on: req.db).unwrap(or:Abort(.notFound)).flatMap { bill in
            bill.delete(on: req.db).transform(to: .noContent)}
    }
    
    
    
    //GET ORDINI DEL CONTO
    func getOrderHandler(_ req:Request)->EventLoopFuture<[Order]> {
        Bill.find(req.parameters.get("id"), on: req.db).unwrap(or:Abort(.notFound)).flatMap { bill in
            bill.$orders.get(on: req.db)}}
}
