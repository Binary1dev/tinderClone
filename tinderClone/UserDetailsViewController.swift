//
//  UserDetailsViewController.swift
//  tinderClone
//
//  Created by Wilson on 2017-02-07.
//  Copyright © 2017 com.Wilson. All rights reserved.
//

import UIKit
import CoreData

class UserDetailsViewController: UIViewController {
    @IBOutlet weak var identitySwitch: UISwitch!
    @IBOutlet weak var interestSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateButton(_ sender: Any) {
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
