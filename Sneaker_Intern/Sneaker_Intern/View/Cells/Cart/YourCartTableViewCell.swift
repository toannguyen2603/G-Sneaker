//
//  YourCartTableViewCell.swift
//  Sneaker_Intern
//
//  Created by Nguyễn Hữu Toàn on 17/10/2022.
//

protocol YourCartTableViewCellDelegate {
    func didTapYourCartDeleteCell(_ cell: YourCartTableViewCell)
    func didTapYourCartPlusQuanlity(_ cell: YourCartTableViewCell)
    func didTapYourCartMinusQuanlity(_ cell: YourCartTableViewCell)
}

import UIKit

class YourCartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
        
    var productManager = ProductManager()
    
    var delegate: YourCartTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpProduct()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func didTapMinusButton(_ sender: Any) {
        delegate?.didTapYourCartMinusQuanlity(self)
    }
    
    @IBAction func didTapPlusButton(_ sender: Any) {
        delegate?.didTapYourCartPlusQuanlity(self)
    }
    
    @IBAction func didTapDeleteButton(_ sender: Any) {
        delegate?.didTapYourCartDeleteCell(self)
    }
    
    func setUpProduct() {
        productView.layer.cornerRadius = productView.frame.size.width / 2
        let angle = CGFloat.pi*1.9
        productImage.transform = productImage.transform.rotated(by: angle)
    }

    
    func config(shoesInfoData: ProductItemMO) {
        productImage.load(url: URL(string: shoesInfoData.image!)!)
        titleLabel.text = shoesInfoData.name
        productView.backgroundColor = UIColor.hexStringToUIColor(hex: shoesInfoData.color ?? "")
        priceLabel.text = "💲\(shoesInfoData.price )"
        quantityLabel.text = "\(shoesInfoData.quantity)"
    }
    
    
}
