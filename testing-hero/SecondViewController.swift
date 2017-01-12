//
//  SecondViewController.swift
//  testing-hero
//
//  Created by Mengying Feng on 10/1/17.
//  Copyright © 2017 iEmRollin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var passedString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("viewDidLoad ✅ \(passedString)")
    }
    

    @IBAction func closeBtnPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SecondViewController: UIViewControllerTransitioningDelegate {
    
    
    
    
}
