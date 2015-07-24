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

    
    var labelFrom = ""
    var array: Array <AnyObject> = []
    
    @IBOutlet var labelInfo: UILabel!
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
        textField.resignFirstResponder()
        println(personitasReload)
        navigationController?.popViewControllerAnimated(true)
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        labelInfo.text = labelFrom
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
