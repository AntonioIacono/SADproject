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
        ingredients.get(use: getAllHandler)
        ingredients.get(":id",use: getHandler)
        ingredients.post(use: createHandler)
        ingredients.put(":id",use: updateHandler)
        ingredients.delete(":id", use: deleteHandler)
    }
    //POST
    func createHandler(_ req:Request)throws ->EventLoopFuture<Ingredient> {
        let ingredient = try req.content.decode(Ingredient.self)
        return ingredient.save(on: req.db).map { ingredient }
    }
    
    //GET
    func getHandler(_ req:Request)->EventLoopFuture<Ingredient> {
        Ingredient.find(req.parameters.get("id"), on: req.db).unwrap(or:Abort(.notFound))}
    
    //GET ALL
    func getAllHandler(req: Request) throws -> EventLoopFuture<[Ingredient]> {
        return Ingredient.query(on: req.db).all()
    }
    
    //PUT
    func updateHandler(_ req:Request)throws ->EventLoopFuture<Ingredient> {
        let updatedIngredient = try req.content.decode(Ingredient.self)
        return Ingredient.find(req.parameters.get("id"),on: req.db).unwrap(or:Abort(.notFound)).flatMap { ingredient in
            ingredient.name = updatedIngredient.name
            ingredient.producer = updatedIngredient.producer
            return ingredient.save(on: req.db).map {ingredient}}
    }
    
    //DELETE
    func deleteHandler(_ req:Request)->EventLoopFuture<HTTPStatus> {
        Ingredient.find(req.parameters.get("id"), on: req.db).unwrap(or:Abort(.notFound)).flatMap { ingredient in
            ingredient.delete(on: req.db).transform(to: .noContent)}
    }
}
