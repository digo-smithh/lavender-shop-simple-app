//
//  ProductsViewModel.swift
//  Lavender Shop
//
//  Created by Rodrigo Smith Rodrigues on 01/08/22.
//

import Foundation

protocol ProductsViewModelProtocol{
    var products: [Product] { get }
    
    func appendProduct(_ product: Product)
    func getLastCode() -> Int
}

class ProductViewModel: ProductsViewModelProtocol{
    var products: [Product] = []
    
    func appendProduct(_ product: Product) {
        var myProduct = product
        myProduct.code = getLastCode() + 1
        products.append(myProduct)
    }
    
    func getLastCode() -> Int {
        return products.last?.code ?? 0
    }
}
