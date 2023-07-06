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
        label.isHidden=false
        // Set the initial text of the text view
        label.text = "We are "
    }
}

