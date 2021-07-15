//
//  Models.swift
//  LadoTsivtsivadze_51
//
//  Created by lado tsivtsivadze on 7/13/21.
//

import UIKit


struct Product: Codable {
    var title: String?
    var description: String?
    var category: String?
    var image: String?
}

struct ProductModel {
    
    var product: Product!
    
    var title: String {
        return product.title ?? ""
    }
    
    var description: String {
        return product.description ?? ""
    }
    
    var category: String {
        return product.category ?? ""
    }
    
    var image: URL {
        return URL(string: product.image ?? "")!
    }
    
    init(using model: Product) {
        product = model
    }
}
