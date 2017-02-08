//
//  ViewController.swift
//  tinderClone
//
//  Created by Wilson on 2017-02-07.
//  Copyright © 2017 com.Wilson. All rights reserved.
//

import UIKit
import CoreData

var currentUser = ""

class ViewController: UIViewController {

    @IBOutlet weak var usenameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getcurrentUser() -> String {
        return currentUser
    }
    
    func setcurrentUser(user:String) {
        currentUser = user
    }

    @IBAction func loginButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        var predicates = [NSPredicate]()
        predicates.append(NSPredicate(format: "username = %@", usenameField.text!))
        predicates.append(NSPredicate(format: "password = %@", passwordField.text!))
        let compoundPredicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: predicates)
        
        request.predicate = compoundPredicate        
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            
            if result.count > 0 {
                performSegue(withIdentifier: "login", sender: self)
                setcurrentUser(user: self.usenameField.text!)
            } else {
                messageLabel.text = "Could not sign in"
            }
            
            
        } catch {
            messageLabel.text = "Could not sign in"
        }
    }

    @IBAction func signUpButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        
        var result = [NSManagedObject]()
        
        if usenameField.text != "" && passwordField.text != "" {
            
            if let password = passwordField.text, let username = usenameField.text {
                let predicate = NSPredicate(format: "username = %@", username)
                
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                
                do {
                    let tempresult = try context.fetch(request)
                    result = tempresult as! [NSManagedObject]
                } catch {
                    messageLabel.text = "Could not sign up"
                }
                
                if result.count > 0 {
                    messageLabel.text = "That Username is already taken"
                } else {
                newUser.setValue(username, forKey: "username")
                newUser.setValue(password, forKey: "password")
                }
            } else {
                messageLabel.text = "Could not Sign up"
            }
        } else {
            messageLabel.text = "Could not Sign up"
        }
        
        do {
            try context.save()
        } catch {
            messageLabel.text = "Could not Sign up"
        }
    }
}

