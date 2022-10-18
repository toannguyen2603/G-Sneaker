//
//  MessagerTalbeView.swift
//  Sneaker_Intern
//
//  Created by Nguyễn Hữu Toàn on 17/10/2022.
//

import UIKit

extension UITableView {
    
    func setMessage(_ message: String) {
        let lblMessage = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        lblMessage.text = message
        lblMessage.textColor = .black
        lblMessage.numberOfLines = 0
        lblMessage.textAlignment = .center
        lblMessage.font = UIFont(name: "TrebuchetMS", size: 20)
        lblMessage.sizeToFit()
        
        self.backgroundView = lblMessage
        self.separatorStyle = .none
    }
    
    func clearBackground() {
        self.backgroundView = nil
    }
}
