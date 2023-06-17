//
//  HowToUseViewController.swift
//  ARKitInteraction
//
//  Created by Tario You on 2023/6/13.
//  Copyright © 2023 Apple. All rights reserved.
//

import UIKit

class HowToUseViewController: UIViewController
{
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the initial text of the text view
        label.text = "1. select location \n2. line up with qr code\n3. press circle button\n4. enjoy"
    }
}

