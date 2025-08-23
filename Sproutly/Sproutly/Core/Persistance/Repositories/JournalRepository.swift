//
//  JournalRepository.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 20.08.2025.
//

import CoreData

final class JournalRepository: JournalRepositoryProtocol {
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func fetchEntries() -> [JournalEntry] {
        let context = coreDataStack.context
        let request: NSFetchRequest<JournalEntry> = JournalEntry.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Fetch failed: \(error)")
            return []
        }
    }
    
    func addEntry(text: String) {
        let context = coreDataStack.context
        let entry = JournalEntry(context: context)
        entry.id = UUID()
        entry.text = text
        entry.date = Date()
        
        coreDataStack.saveContext()
    }
    
    func deleteEntry(_ entry: JournalEntry) {
        let context = coreDataStack.context
        context.delete(entry)
        coreDataStack.saveContext()
    }
}
