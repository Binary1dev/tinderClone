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
    var person = 0
    var profiles = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let users = ["Girl","Lady","Female","Dude","Human"]
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        
        let swipe = UIPanGestureRecognizer(target: self, action: #selector(self.swiped(gestureRecognizer:)))
        
        profileImage.addGestureRecognizer(swipe)
        
        for (index, value) in users.enumerated() {
            newUser.setValue(value, forKey: "username")
            newUser.setValue(String(index), forKey: "password")
            profiles.append(UIImage(named:"human"+String(index)+".jpg")!)
            do {
                try context.save()
            } catch {
                print("couldn't create user")
            }
        }
        
        profileImage.image = profiles[person]

    }
    
    func swiped(gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: view)
        
        let image = gestureRecognizer.view as! UIImageView
        
        image.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = image.center.x - self.view.bounds.width / 2
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)
        
        let scale = min(abs(100/xFromCenter), 1)
        
        var stretchAndRotation = rotation.scaledBy(x: scale, y: scale)
        
        image.transform = stretchAndRotation
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            if image.center.x < 100 && person < 4 {
                person += 1
                image.image = profiles[person]
            } else if image.center.x > self.view.bounds.width - 100 && person > 0{
                person -= 1
                image.image = profiles[person]
            }
            rotation = CGAffineTransform(rotationAngle: 0)
            stretchAndRotation = rotation.scaledBy(x: 1, y: 1)
            image.transform = stretchAndRotation
            image.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkProfileButton(_ sender: Any) {
        performSegue(withIdentifier: "userProfile", sender: self)
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
