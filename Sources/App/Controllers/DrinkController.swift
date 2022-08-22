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
        drinks.get(use: getAllHandler)
        drinks.get(":id",use: getHandler)
        drinks.get(":id","ingredients", use: getIngredientsHandler)
        drinks.post(use: createHandler)
        drinks.post(":drink_id","ingredients",":ingredient_id",use: addIngredientHandler)
        drinks.put(":id",use: updateHandler)
        drinks.delete(":id", use: deleteHandler)
    }
    
    //POST
    func createHandler(_ req:Request)throws ->EventLoopFuture<Drink> {
        let drink = try req.content.decode(Drink.self)
        return drink.save(on: req.db).map { drink }
    }
    
    //GET
    func getHandler(_ req:Request)->EventLoopFuture<Drink> {
        Drink.find(req.parameters.get("id"), on: req.db).unwrap(or:Abort(.notFound))}
    
    //GET ALL
    func getAllHandler(req: Request) throws -> EventLoopFuture<[Drink]> {
        return Drink.query(on: req.db).all()
    }
    
    //PUT
    func updateHandler(_ req:Request)throws ->EventLoopFuture<Drink> {
        let updatedDrink = try req.content.decode(Drink.self)
        return Drink.find(req.parameters.get("id"),on: req.db).unwrap(or:Abort(.notFound)).flatMap { drink in
            drink.name = updatedDrink.name
            drink.description = updatedDrink.description
            drink.price = updatedDrink.price
            drink.availability = updatedDrink.availability
            return drink.save(on: req.db).map {drink}}
    }
    
    //DELETE
    func deleteHandler(_ req:Request)->EventLoopFuture<HTTPStatus> {
        Drink.find(req.parameters.get("id"), on: req.db).unwrap(or:Abort(.notFound)).flatMap { drink in
            drink.delete(on: req.db).transform(to: .noContent)}
    }
    
    //POST INGREDIENTI DEL DRINK
    func addIngredientHandler(_ req:Request)->EventLoopFuture<HTTPStatus> {
        let drinkQuery = Drink.find(req.parameters.get("drink_id"), on: req.db).unwrap(or:Abort(.notFound))
        let ingredientQuery = Ingredient.find(req.parameters.get("ingredient_id"), on: req.db).unwrap(or:Abort(.notFound))
        return drinkQuery.and(ingredientQuery).flatMap { drink, ingredient in drink.$ingredient.attach(ingredient, on: req.db).transform(to: .created)}
    }
    
    //GET INGREDIENTI DEL DRINK
    func getIngredientsHandler(_ req:Request)->EventLoopFuture<[Ingredient]> {
          Drink.find(req.parameters.get("id"), on: req.db).unwrap(or:Abort(.notFound)).flatMap { drink in
          drink.$ingredient.query(on: req.db).all()}
    }
}
