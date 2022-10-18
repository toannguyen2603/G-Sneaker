//
//  ViewController.swift
//  Sneaker_Intern
//
//  Created by Nguyễn Hữu Toàn on 17/10/2022.
//

import UIKit

class ViewController: UIViewController {

    var cart = ProductManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    var result: ShoesResponse? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var circleView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Our Products"
        setupTableView()
        configureBarItem()   
        parseJSON()
        view.insertSubview(circleView, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height: CGFloat = 150
        circleView.frame = CGRect(x: -20, y: -20, width: height, height: height)
        circleView.layer.cornerRadius = height / 2
        circleView.backgroundColor = .systemYellow
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func goToYourCart(){
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "YourCart") as! YourCartViewController
        self.navigationController?.pushViewController(vc, animated:true)
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
        let shoes = result?.shoes[indexPath.item]
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
        let product = result?.shoes[indexPath.item]
        
        if let product = product {
            cart.insertNewProduct(product, quantity: 1)
        }
    }
    
}


