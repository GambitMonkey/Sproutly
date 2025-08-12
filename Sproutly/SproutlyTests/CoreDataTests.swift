//
//  CoreDataTests.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 13.08.2025.
//


import XCTest
import CoreData
@testable import Sproutly

final class CoreDataTests: XCTestCase {
    
    var repository: PlantRepository!
    var coreDataStack: CoreDataStack!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        coreDataStack = CoreDataStack(inMemory: true) // ✅ In-memory for tests
        repository = PlantRepository(context: coreDataStack.context)
    }
    
    override func tearDownWithError() throws {
        repository = nil
        coreDataStack = nil
        try super.tearDownWithError()
    }
    
    func testSavingAndFetchingPlant() throws {
        repository.createPlant(name: "Test Plant")
        
        let plants = repository.fetchAllPlants()
        XCTAssertEqual(plants.count, 1)
        XCTAssertEqual(plants.first?.name, "Test Plant")
    }
}
