//
//  CustomCell.swift
//  studydrive
//
//  Created by Gualberto on 11/05/2019.
//  Copyright © 2019 Gualberto. All rights reserved.
//

import Foundation
import UIKit

class CustomCell:UITableViewCell {

    //MARK: Outlet and Var
    var newProduct : String?

    //MARK: Views setup
    var newProductView : UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        //Style to TextView
        textView.font = UIFont.boldSystemFont(ofSize: 12.0)
        
        //Set background to check the correct position
        //textView.backgroundColor = UIColor.green  //To control if text fit on it
        return textView
    }()
    
    
    //MARK: Views init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Adding subviews
        self.addSubview(newProductView)
       
        //Adding constrain
        newProductView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        newProductView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        //newProductView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //newProductView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        //newProductView.heightAnchor.constraint(equalToConstant: 50).isActive = true
      
    }
    
    //MARK: Init layout subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        if let newProduct = newProduct {
            newProductView.text = "\(newProduct.uppercased())"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
