import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: DrinkController())
    try app.register(collection: IngredientController())
}
