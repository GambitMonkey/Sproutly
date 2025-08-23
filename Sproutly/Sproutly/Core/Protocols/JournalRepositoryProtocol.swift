//
//  JournalRepositoryProtocol.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 20.08.2025.
//

protocol JournalRepositoryProtocol {
    func fetchEntries() -> [JournalEntry]
    func addEntry(text: String)
    func deleteEntry(_ entry: JournalEntry)
}
