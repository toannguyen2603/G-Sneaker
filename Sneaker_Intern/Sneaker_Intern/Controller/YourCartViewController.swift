//
//  YourCartViewController.swift
//  Sneaker_Intern
//
//  Created by Nguyễn Hữu Toàn on 17/10/2022.
//

import UIKit

class YourCartViewController: UIViewController {
    
    var productManager = ProductManager()
    var cartManager = CartManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        configureBarItem()
        productManager.getAllProduct(tableView: tableView.self)
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "YourCartTableViewCell", bundle: nil), forCellReuseIdentifier: "YourCartTableViewCell")
    }

    private func configureBarItem() {
        navigationItem.largeTitleDisplayMode = .never
        let logo = UIBarButtonItem.menuButton(self, action: #selector(didTappedRedirectBackHome), imageName: "nikeIcon", width: 60, height: 30)
        self.navigationItem.leftBarButtonItem = logo
        
    }
    
    @objc func didTappedRedirectBackHome() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
extension YourCartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productManager.models.count == 0 {
            tableView.setMessage("Your cart is empty")
        } else {
            tableView.clearBackground()
        }
        
        return productManager.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YourCartTableViewCell", for: indexPath) as? YourCartTableViewCell else {
            fatalError("Faild dequeue resuble cell")
        }
        cell.selectionStyle = .none
        let model = productManager.models[indexPath.row]
        cell.config(shoesInfoData: model)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let font = UIFont(name: "HelveticaNeue-Bold", size: 35)!

        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50)) 
        let titleLabel = UILabel()
        titleLabel.text = "Your Cart"
        titleLabel.font = font
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(titleLabel)
        
        let priceLabel = UILabel()
        priceLabel.text = "💲\(cartManager.totalPrice(items: productManager.models))"
        priceLabel.font = UIFont(name: "Rubik-Bold", size: 20)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textAlignment = .center
        header.addSubview(priceLabel)
        
        // make constraint layout
        NSLayoutConstraint.activate([
            // title
            titleLabel.topAnchor.constraint(equalTo: header.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 30),
            titleLabel.bottomAnchor.constraint(equalTo: header.bottomAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            // price
            priceLabel.topAnchor.constraint(equalTo: header.topAnchor),
            priceLabel.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -30),
            priceLabel.bottomAnchor.constraint(equalTo: header.bottomAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension YourCartViewController: YourCartTableViewCellDelegate {
    
    func didTapYourCartDeleteCell(_ cell: YourCartTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = productManager.models[indexPath.row]
        productManager.deleteProduct(item: item, tableView: tableView.self)
    }
    
    func didTapYourCartPlusQuanlity(_ cell: YourCartTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = productManager.models[indexPath.row]
        productManager.updateProduct(item: item, quantity: Int(item.quantity) + 1, tableView: tableView.self)
    }
    
    func didTapYourCartMinusQuanlity(_ cell: YourCartTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = productManager.models[indexPath.row]
        if item.quantity > 1 {
            productManager.updateProduct(item: item, quantity: Int(item.quantity) - 1, tableView: tableView.self)
        } else {
            productManager.deleteProduct(item: item, tableView: tableView.self)
        }
    }
}



