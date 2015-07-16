//
//  DataTableViewController.swift
//  Table-Realm-Data
//
//  Created by Jonatan Santa Cruz Soria on 16/07/15.
//  Copyright (c) 2015 Jonatan Santa Cruz Soria. All rights reserved.
//

import UIKit
import RealmSwift
import Realm


class Person: Object {
    dynamic var name = ""
}


class DataTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var array: Array <AnyObject> = []

    @IBOutlet var textField: UITextField!
    @IBAction func saveButton(sender: AnyObject) {
        
        if textField.text != "" {
            var info = textField.text
            array.append(info)
            
            let personita = Person()
            personita.name = info
            
            let realm = Realm()
            
            realm.write {
                realm.add(personita)
            }
        }
            
        else {
            println("TONTO")
        }
        
        textField.text = ""
        tableView.reloadData()
    }
    
    
    @IBAction func deleteAll(sender: AnyObject) {
        let realm = Realm()
        
        realm.write {
            realm.deleteAll()
        }
        
        array = []
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        array = []
        
        var personitasReload = Realm().objects(Person)
        println(personitasReload)
        
        for personita in personitasReload {
            array.append(personita.name)
        }
        
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var personitasReload = Realm().objects(Person)
        
        for personita in personitasReload {
            array.append(personita.name)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return 1
    }
    
    @objc override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return array.count
    }
    
    
    @objc override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let idCell: String = "Cell"
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(idCell) as! UITableViewCell
        cell.textLabel!.text = self.array[indexPath.row] as? String
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        
        
        return true
    }
    
    
    var deletes: Object = Person()
    
    func deleteRealm() {
        var realm = Realm()
        
        realm.write {
            realm.delete(self.deletes)
        }
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
         var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        if editingStyle == .Delete {
            var arraynumber: AnyObject = array[indexPath.row]
            
            array.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            var realm = Realm()
            var personitasReload = Realm().objects(Person)
            
            for personita in personitasReload {
                if personita.name == arraynumber as! String {
                    deletes = personita
                }
              }
            
            deleteRealm()

    

        }
        else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
    }
    
    
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            var nextScene = segue.destinationViewController as! ChangeViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            nextScene.labelFrom = (self.array[indexPath!.row] as? String)!
        }
 
}
