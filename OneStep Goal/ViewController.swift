//
//  ViewController.swift
//  OneStep Goal
//
//  Created by Bernard Huff on 10/2/18.
//  Copyright © 2018 Flyhightech.LLC. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    
    @IBOutlet weak var importantCheckbox: NSButton!
    
    var toDoItems : [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getToDoListItem()
        
    }
    
//  Below is the code that fetches the to do list items
    
    func getToDoListItem() {
        
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
//  Below is a do, try, catch, statement
            
            do {
                toDoItems = try context.fetch(ToDoItem.fetchRequest())
            } catch {}
        }
        
    }

    @IBAction func addClicked(_ sender: Any) {
        
        if textField.stringValue != "" {
            
            if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let toDoItem = ToDoItem(context: context)
                
                toDoItem.name = textField.stringValue
                
                if importantCheckbox.state.rawValue == 0 {
                    toDoItem.important = false
                } else {
                    toDoItem.important = true
                }
                
                (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
                
//  Below is the code that clears out the screen after user enters new item.
                
                textField.stringValue = ""
                importantCheckbox.state = NSControl.StateValue(rawValue: 0)
                getToDoListItem()
                
            }
        }
    }
    


    
    
    
    
    
    
    
} //    End of the view controller class

