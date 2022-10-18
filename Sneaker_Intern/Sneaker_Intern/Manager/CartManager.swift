//
//  CartManager.swift
//  Sneaker_Intern
//
//  Created by Nguyễn Hữu Toàn on 17/10/2022.
//

import Foundation

class CartManager {
    
    func totalPrice(items: [ProductItemMO]) -> String {
        var total_price = 0.00
        for item in items {
            total_price += Double(item.quantity) * item.price
        }
        let total_string = String(format: "%.2f", total_price)
        return total_string
    }
    
    
}
