//
//  YourCartTableViewCell.swift
//  Sneaker_Intern
//
//  Created by Nguyễn Hữu Toàn on 17/10/2022.
//

import UIKit

class YourCartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productImage: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func didTapMinusButton(_ sender: Any) {
    }
    
    @IBAction func didTapPlusButton(_ sender: Any) {
    }
    
    @IBAction func didTapDeleteButton(_ sender: Any) {
    }
    
    func config(shoesInfoData: ProductItemMO) {
        productView.backgroundColor = UIColor.hexStringToUIColor(hex: "\(shoesInfoData.color)")
//        productImage.load(url: shoesInfoData.image)
        titleLabel.text = shoesInfoData.name
        priceLabel.text = "💲\(shoesInfoData.price )"
        quantityLabel.text = "\(shoesInfoData.quantity)"
    }
    
    
}
