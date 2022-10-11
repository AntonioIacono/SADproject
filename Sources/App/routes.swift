import Fluent
import Vapor

func routes(_ app: Application) throws {

    app.get{ req in
        return "it Works!"
    }
    try app.register(collection: DrinkController())
    try app.register(collection: IngredientController())
    
}
