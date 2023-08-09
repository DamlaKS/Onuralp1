//
//  Webservice.swift
//  SpaceX
//
//  Created by Damla KS on 9.08.2023.
//

import Foundation

enum ServiceError: Error {
    case serverError
    case parsingError
}

class Webservice {
    var launches: [SpaceXData] = []
    
    func takeData(completion: @escaping (Result<[SpaceXData], ServiceError>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches/latest") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let launchData = try JSONDecoder().decode(SpaceXData.self, from: data)
                    self.launches.append(launchData)
                    completion(.success([launchData]))
                } catch {
                    completion(.failure(.parsingError))
                }
            } else {
                completion(.failure(.serverError))
            }
        }.resume()
    }
}
