//
//  ShoesTableViewCell.swift
//  Sneaker_Intern
//
//  Created by Nguyễn Hữu Toàn on 17/10/2022.
//

protocol ShoesTableViewCellDelegate {
    func handerAddItemToCart(_data: ShoesTableViewCell) 
}

import UIKit

class ShoesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shoesBgView: UIView! 
    @IBOutlet weak var shoesImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriotionTextView: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var shoesData: ResultItem?
    
    var delegate: ShoesTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
        let angle = CGFloat.pi*1.9
        shoesImage.transform = shoesImage.transform.rotated(by: angle)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpView() {
        shoesBgView.layer.masksToBounds = true
        shoesBgView.layer.cornerRadius = 40.0
        addToCartButton.backgroundColor = .yellow
    }
    
    @IBAction func didTapAddToCart(_ sender: Any) {
        addToCartButton.isEnabled = false
        addToCartButton.setImage(UIImage(named: "checkIcon"), for: .normal)
        addToCartButton.setTitle("", for: .normal)
        delegate?.handerAddItemToCart(_data: self)
    }
    
    func config(shoesInfoData: ResultItem) {
        shoesData = shoesInfoData
        shoesBgView.backgroundColor = UIColor.hexStringToUIColor(hex: "\(shoesData!.color)")
        shoesImage?.load(url: shoesData!.image)
        titleLabel?.text = shoesData?.name
        descriotionTextView?.text = shoesData?.description
        priceLabel?.text = "💲\(shoesData?.price ?? 0.0)"
    }
    
    
    
}

