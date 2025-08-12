//
//  PlantRepository.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 13.08.2025.
//


import CoreData

final class PlantRepository: PlantRepositoryProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }
    
    func createPlant(name: String) {
        let plant = Plant(context: context)
        plant.id = UUID()
        plant.name = name
        plant.dateAdded = Date()
        
        do {
            try context.save()
        } catch {
            print("Failed to save plant: \(error)")
        }
    }
    
    func fetchAllPlants() -> [Plant] {
        let request: NSFetchRequest<Plant> = Plant.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch plants: \(error)")
            return []
        }
    }
}
