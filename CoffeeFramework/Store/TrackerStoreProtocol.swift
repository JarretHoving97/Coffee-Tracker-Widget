//
//  TrackerStoreProtocol.swift
//  Track My Coffee
//
//  Created by Jarret on 09/02/2025.
//

public protocol TrackerStoreProtocol {
    func retrieve(_ date: Date) -> Int?
    func store(number: Int, for date: Date)
}
