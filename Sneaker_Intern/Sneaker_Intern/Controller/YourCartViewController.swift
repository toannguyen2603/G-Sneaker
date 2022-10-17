//
//  YourCartViewController.swift
//  Sneaker_Intern
//
//  Created by Nguyễn Hữu Toàn on 17/10/2022.
//

import UIKit

class YourCartViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var models = [ProductItemMO]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        configureBarItem()
        print("Hello your cart")
        
        print(models.count)
        
        getAllProduct()
    
    }
    
    private func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: "YourCartTableViewCell", bundle: nil), forCellReuseIdentifier: "YourCartTableViewCell")
    }
    
    private func configureBarItem() {
        let logo = UIBarButtonItem.menuButton(self, action: #selector(didTappedRedirectBackHome), imageName: "nikeIcon", width: 60, height: 30)
        self.navigationItem.leftBarButtonItem = logo
    }
    
    @objc func didTappedRedirectBackHome() {
        navigationController?.popViewController(animated: true)
    }
    
    func getAllProduct() {
        do {
            models = try context.fetch(ProductItemMO.fetchRequest())
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        } catch {
            // error here
        }
    }
    
    func insertNewProduct(_ data: ResultItem, quanlity: Int) {
        let newProduct = ProductItemMO(context: context)
        
        newProduct.id = Int32(data.id)
        newProduct.name = data.name
        newProduct.image = "\(data.image)"
        newProduct.price = data.price
        newProduct.color = data.color
        newProduct.quantity = Int32(quanlity)
        
        do {
            try context.save()
            print("Save success")
        } catch { 
            // error here
        }
    }
    
    func updateProduct(item: ProductItemMO, quantity: Int) {
        item.quantity = Int32(quantity)
        do {
            try context.save()
        } catch {
            // error here
        }
    }
    
    func deleteProduct(item: ProductItemMO) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            
        }
    }

}
extension YourCartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YourCartTableViewCell", for: indexPath) as? YourCartTableViewCell else {
            fatalError("Faild dequeue resuble cell")
        }
        print("Hello everyone")
        let model = models[indexPath.row]
        cell.config(shoesInfoData: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


