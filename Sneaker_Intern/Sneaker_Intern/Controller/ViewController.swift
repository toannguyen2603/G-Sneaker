//
//  ViewController.swift
//  Sneaker_Intern
//
//  Created by Nguyễn Hữu Toàn on 17/10/2022.
//

import UIKit

class ViewController: UIViewController {

    
    
    var result: ShoesResponse?
    var cart = YourCartViewController()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Our Products"
        setupTableView()
        configureBarItem()   
        parseJSON()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ShoesTableViewCell", bundle: nil), forCellReuseIdentifier: "ShoesTableViewCell")
    }
    
    private func configureBarItem() {
        let logo = UIBarButtonItem.menuButton(self, action: #selector(didTappedReloadTable), imageName: "nikeIcon", width: 60, height: 30)
        self.navigationItem.leftBarButtonItem = logo
        
        let cart = UIBarButtonItem.menuButton(self, action: #selector(goToYourCart), imageName: "cartIcon", width: 35, height: 35)
        self.navigationItem.rightBarButtonItem = cart
    }
    
    func parseJSON() {
        guard let path = Bundle.main.path(forResource: "shoes", ofType: "json") else { return }
        
        let url = URL(fileURLWithPath: path)
                
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(ShoesResponse.self, from: jsonData)
            
            return
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @objc func didTappedReloadTable() {
        print("hekko")
    }
    
    @objc func goToYourCart(){
        let vc = YourCartViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.shoes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoesTableViewCell", for: indexPath) as? ShoesTableViewCell else {
            fatalError("Faild reusable cell")
        }
        cell.selectionStyle = .none
        let shoes = result?.shoes[indexPath.row]
        cell.config(shoesInfoData: shoes!)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension ViewController: ShoesTableViewCellDelegate {
    func handerAddItemToCart(_data: ShoesTableViewCell) {
        guard let indexPath = tableView.indexPath(for: _data) else { return }
        let product = result?.shoes[indexPath.row]
        
        if let product = product {
            cart.insertNewProduct(product, quanlity: 1)
        }
    }
    
}



extension UIBarButtonItem {
    
    static func menuButton(_ target: Any?, action: Selector, imageName: String, width: CGFloat, height: CGFloat) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let barItem = UIBarButtonItem(customView: button)
        barItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barItem.customView?.heightAnchor.constraint(equalToConstant: height).isActive = true
        barItem.customView?.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        return barItem
    }
}

