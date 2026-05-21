//
//  DataController.swift
//  icalories
//
//  Created by Sreejith, Shriya (Student) on 2/15/26.
//

import Foundation
import CoreData
import Combine

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FoodModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    func save(context: NSManagedObjectContext) {
        do{
            try context.save()
            print("Data saved!!! WUHU!!!")
        } catch {
            print("We could not save the data...")
        }
    }
    func addFood(name: String, calories: Double, context: NSManagedObjectContext){
        let food = Food(context: context)
        food.id = UUID()
        food.name = name
        food.date = Date()
        food.calories = calories
        
        save(context: context)
    }
    func editFood(food: Food, name: String, calories: Double, context: NSManagedObjectContext){
        food.name = name
        food.date = Date()
        food.calories = calories
        
        save(context: context)
    }
    
}
