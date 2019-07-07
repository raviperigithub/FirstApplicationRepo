//
//  ViewController.swift
//  FirstApplicationRepo
//
//  Created by Srinivasa Ravi Teja Peri on 7/1/19.
//  Copyright © 2019 HarshaRaviGitHub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func ButtonAction(_ sender: Any) {
        Label.text = "Hello";
    }
    
    @IBOutlet weak var Label: UILabel!
    
    override func viewDidLoad() {
        Label.text="InViewLoad";
        super.viewDidLoad()
// Do any additional setup after loading the view.
    }


}

