//
//  SwipeViewController.swift
//  tinderClone
//
//  Created by Wilson on 2017-02-08.
//  Copyright © 2017 com.Wilson. All rights reserved.
//

import UIKit
import CoreData

class SwipeViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let users = ["Girl","Lady","Female","Dude","Human"]
        
        var profiles = [UIImage]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        
        for (index, value) in users.enumerated() {
            newUser.setValue(value, forKey: "username")
            newUser.setValue(index, forKey: "password")
            profiles.append(UIImage(named:"human"+String(index)+".jpg")!)
            do {
                try context.save()
            } catch {
                //fuck lol
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkProfileButton(_ sender: Any) {
        performSegue(withIdentifier: "userDetails", sender: self)
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
