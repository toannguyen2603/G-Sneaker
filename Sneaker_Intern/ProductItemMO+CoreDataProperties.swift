//
//  ProductItemMO+CoreDataProperties.swift
//  Sneaker_Intern
//
//  Created by Nguyễn Hữu Toàn on 18/10/2022.
//
//

import Foundation
import CoreData


extension ProductItemMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductItemMO> {
        return NSFetchRequest<ProductItemMO>(entityName: "ProductItem")
    }

    @NSManaged public var id: Int32
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var color: String?
    @NSManaged public var quantity: Int32
    @NSManaged public var price: Double

}

extension ProductItemMO : Identifiable {

}
