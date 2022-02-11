//
//  ViewController.swift
//  RocketChat
//
//  Created by Aurelio Le Clarke on 09.02.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var MainTitle: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        super.viewWillDisappear(animated)
    }
    
    
    func animatedTitle() {
        let title = K.appName
        MainTitle.text = ""
        var indexChar = 0.0
        for letter in title {
            Timer.scheduledTimer(withTimeInterval: 0.1 * indexChar, repeats: false) { (timer) in
                self.MainTitle.text?.append(letter)
            }
        indexChar += 1
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animatedTitle()
    }


}

