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
    
    var plantRepository: PlantRepository!
    var journalRepository: JournalRepository!
    var coreDataStack: CoreDataStack!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        coreDataStack = CoreDataStack(inMemory: true) // ✅ In-memory for tests
        plantRepository = PlantRepository(coreDataStack: coreDataStack)
        journalRepository = JournalRepository(coreDataStack: coreDataStack)
    }
    
    override func tearDownWithError() throws {
        plantRepository = nil
        journalRepository = nil
        coreDataStack = nil
        try super.tearDownWithError()
    }
    
    func testSavingAndFetchingPlant() throws {
        plantRepository.createPlant(name: "Test Plant")
        
        let plants = plantRepository.fetchAllPlants()
        XCTAssertEqual(plants.count, 1)
        XCTAssertEqual(plants.first?.name, "Test Plant")
    }
    
    func testAddAndFetchEntries() {
        // Given
        XCTAssertEqual(journalRepository.fetchEntries().count, 0, "Should start empty")
        
        // When
        journalRepository.addEntry(text: "First entry")
        let entries = journalRepository.fetchEntries()
        
        // Then
        XCTAssertEqual(entries.count, 1, "Should have one entry after adding")
        XCTAssertEqual(entries.first?.text, "First entry")
    }
    
    func testDeleteEntry() {
        // Given
        journalRepository.addEntry(text: "Entry to delete")
        var entries = journalRepository.fetchEntries()
        XCTAssertEqual(entries.count, 1)
        
        // When
        if let entry = entries.first {
            journalRepository.deleteEntry(entry)
        }
        entries = journalRepository.fetchEntries()
        
        // Then
        XCTAssertEqual(entries.count, 0, "Should have 0 entries after deletion")
    }
    
    func testMultipleEntriesOrder() {
        // Given
        journalRepository.addEntry(text: "Older entry")
        sleep(1) // ensure different timestamps
        journalRepository.addEntry(text: "Newer entry")
        sleep(1)
        journalRepository.addEntry(text: "Newest entry")
        
        // When
        let entries = journalRepository.fetchEntries()
        
        // Then
        XCTAssertEqual(entries.count, 3)
        XCTAssertEqual(entries.first?.text, "Newest entry", "Entries should be sorted by date descending")
    }
}
