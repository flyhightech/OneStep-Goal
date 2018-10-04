//
//  ViewController.swift
//  OneStep Goal
//
//  Created by BernieDaEngineer on 10/2/18.
//  Copyright © 2018 Flyhightech.LLC. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var importantCheckbox: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    
    var toDoItems : [ToDoItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getToDoListItem()
        
    }
    
// MARK: - The code that fetches the to do list items
    
    func getToDoListItem() {
        
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
// Below is a do, try, catch, statement
            
            do {
                toDoItems = try context.fetch(ToDoItem.fetchRequest())
                print(toDoItems.count)
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
                
//MARK: - Below is the code that clears out the screen
                
                textField.stringValue = ""
                importantCheckbox.state = NSControl.StateValue(rawValue: 0)
                getToDoListItem()
                
            }
        }
    }
    
    // MARK: - Rows in each cell of the app.
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "importantCell"), owner: self) as? NSTableCellView {
            
            cell.textField?.stringValue = "Hello World"
            
            return cell
        }
        
        return nil
        
    }
    


    
    
    
    
    
    
    
}// MARK: - End of the document!!!


