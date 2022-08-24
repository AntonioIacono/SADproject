import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "Localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
    ), as: .psql)

    app.migrations.add(CreateIngredient())
    app.migrations.add(CreateRecipe())
    app.migrations.add(CreateDrink())
    app.migrations.add(CreateOrder())
    app.migrations.add(CreateSubOrder())
    app.migrations.add(CreateBill())
    
//    app.migrations.add(CreateOrdination())
    try app.autoMigrate().wait()
    app.views.use(.leaf)

    

    // register routes
    try routes(app)
}
