//
//  ProductManager.swift
//  Sneaker_Intern
//
//  Created by Nguyễn Hữu Toàn on 17/10/2022.
//

import UIKit

class ProductManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var models = [ProductItemMO]()
    
    func getAllProduct(tableView: UITableView) {
        do {
            models = try context.fetch(ProductItemMO.fetchRequest())
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {
                // error here
        }
    }
    
    func insertNewProduct(_ data: ResultItem, quantity: Int) {
        
        let newProduct = ProductItemMO(context: context)
        
        if checkIfItemExist(id: data.id) {
            print("Item is duplicate")
            context.delete(newProduct)
            do {
                try context.save()
            } catch {
                print("Error when delete item")
            }
        } else {
            newProduct.id = Int32(data.id)
            newProduct.name = data.name
            newProduct.image = "\(data.image)"
            newProduct.price = data.price
            newProduct.color = data.color
            newProduct.quantity = Int32(quantity)
            do {
                try context.save()
                print("Save success")
            } catch { 
                
            }
        }
    }
    
    func updateProduct(item: ProductItemMO, quantity: Int, tableView: UITableView) {
        item.quantity = Int32(quantity)
        do {
            try context.save()
            getAllProduct(tableView: tableView)
        } catch {
                // error here
        }
    }
    
    func deleteProduct(item: ProductItemMO, tableView: UITableView) {
        context.delete(item)
        do {
            try context.save()
            getAllProduct(tableView: tableView)
            print("Delete success")
        } catch {
            
        }
    }
    
    func checkIfItemExist(id: Int) -> Bool {
        let fetchRequest =  ProductItemMO.fetchRequest()
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "id == %d" ,id)
        
        do {
            let count = try context.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
}
