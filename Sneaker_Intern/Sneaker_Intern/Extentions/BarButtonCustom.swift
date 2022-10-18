//
//  BarButtonCustom.swift
//  Sneaker_Intern
//
//  Created by Nguyễn Hữu Toàn on 17/10/2022.
//

import UIKit

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

