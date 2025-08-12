//
//  PlantRepositoryProtocol.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 13.08.2025.
//


protocol PlantRepositoryProtocol {
    func createPlant(name: String)
    func fetchAllPlants() -> [Plant]
}