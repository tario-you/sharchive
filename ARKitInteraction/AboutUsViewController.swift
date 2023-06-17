//
//  AboutUsViewController.swift
//  ARKitInteraction
//
//  Created by Tario You on 2023/6/13.
//  Copyright © 2023 Apple. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the initial text of the text view
        label.text = "We are 5 highschool students from shanghai american school and we all hate aaron lowkey hes a bitch"
    }
}

