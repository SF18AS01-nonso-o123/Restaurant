//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Chinonso Obidike on 3/26/19.
//  Copyright © 2019 Chinonso Obidike. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: ViewController {
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!)"
    }
    

    
    
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
