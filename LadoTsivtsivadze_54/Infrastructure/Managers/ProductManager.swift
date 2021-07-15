//
//  BookManager.swift
//  LadoTsivtsivadze_51
//
//  Created by lado tsivtsivadze on 7/13/21.
//

import UIKit

class ProductManager {
    
    private var networkManager: NetworkManager = NetworkManager()
    
    func getProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        networkManager.get(model: [Product].self, with: Endpoints.productsEndpoint) { result in
            switch result {
            case .success(let products):
                let items = products.map { ProductModel(using: $0) }
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
