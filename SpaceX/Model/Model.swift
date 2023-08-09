//
//  Model.swift
//  SpaceX
//
//  Created by Damla KS on 5.08.2023.
//

import Foundation

struct SpaceXData: Codable {
    let links: Links?
    let name: String
    let details: String?
}

struct Links: Codable {
    let patch: Patch?
}

struct Patch: Codable {
    let small: String
    let large: String
}
