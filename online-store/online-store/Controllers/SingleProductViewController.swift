//
//  SingleProductViewController.swift
//  online-store
//
//  Created by Moore on 01.10.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit
import SDWebImage
import MaterialComponents.MaterialSnackbar

class SingleProductViewController: BaseViewController {
    
    var product: Product!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    @IBAction func addProductButtonTapped(_ sender: UIButton) {
        App.appManagement.shoppingCart.addProduct(product: self.product)
        print(App.appManagement.shoppingCart.countProductsInCart(), " - products count in cart.")
        let message = MDCSnackbarMessage()
        message.text = "\(product.title!) was added in cart."
        MDCSnackbarManager.show(message)
        showShoppingCartButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productImageView.sd_setImage(with: URL(string: ("\(product.imageUrl ?? "Empty Img")")), placeholderImage: UIImage(named: "emptyimg.png"))
        self.labelProductName.text = product.title
        self.labelRating.text = (product.rating != nil) ? "Rating: \(product.rating as! Double)" : "Rating is missing"
        self.labelPrice.text = (product.price != nil) ? "Price: \(product.price as! Int)" : "Price is missing"
        self.labelDescription.text = "Description:" + ((product.productDescription != nil) ? product.productDescription : "is missing.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showShoppingCartButton()
    }
    
    
}
