//
//  ViewController.swift
//  InteractiveButtons
//
//  Created by Leoan Ranjit on 5/13/22.
//

import UIKit
import LeoButtons

class ViewController: UIViewController {
    
    @IBOutlet weak var btnLoad: LeoButtons!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLoad.animates = true
    }

    @IBAction func btnLoadAction(_ sender: Any) {
        btnLoad.startLoading()
        
    }
    @IBAction func btnStopLoading(_ sender: Any) {
        btnLoad.stopLoading()
    }
    
}

