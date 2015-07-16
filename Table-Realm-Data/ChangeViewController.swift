//
//  ChangeViewController.swift
//  Table-Realm-Data
//
//  Created by Jonatan Santa Cruz Soria on 16/07/15.
//  Copyright (c) 2015 Jonatan Santa Cruz Soria. All rights reserved.
//

import UIKit
import Realm
import RealmSwift




class ChangeViewController: UIViewController {

    @IBOutlet var labelInfo: UILabel!
    var labelFrom = ""
     var array: Array <AnyObject> = []
    
    @IBOutlet var textField: UITextField!
    

    
   
    
    
  
    
    @IBAction func sendButton(sender: AnyObject) {
        var personitasReload = Realm().objects(Person)
        let realm = Realm()
        for personita in personitasReload {
            if personita.name == labelFrom {
                realm.write {
                    personita.name = self.textField.text
                }

            }

            println(personita.description)
            
        }
        
        println(personitasReload)
        
        
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelInfo.text = labelFrom
        
      
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
