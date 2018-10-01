//
//  SingleProductViewController.swift
//  online-store
//
//  Created by Moore on 01.10.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

class SingleProductViewController: UIViewController {
    
    @IBOutlet weak var productName: UILabel!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productName.text = product.title
        
        
    }
    

}
