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
    @IBOutlet weak var deleteButton: NSButton!
    
    var toDoItems : [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getToDoListItem()
        
    }
    
    // MARK: - The code that fetches the to do list items
    
    func getToDoListItem() {
        
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            do {
                toDoItems = try context.fetch(ToDoItem.fetchRequest())
            } catch {}
            
        }
        
        tableView.reloadData()
        
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
                
                //  Below is the code that clears out the screen
                
                textField.stringValue = ""
                importantCheckbox.state = NSControl.StateValue(rawValue: 0)
                getToDoListItem()
                
            }
        }
    }
    
    // MARK: -  Below is the code for the DELETE button
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        
        let toDoItem = toDoItems[tableView.selectedRow]
        
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            context.delete(toDoItem)
            
            (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
        }
    }
    
    // MARK: - Rows in each cell of the app.
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let toDoItem = toDoItems[row]
        
    // MARK: - Important Column
        
        if (tableColumn?.identifier)!.rawValue == "importantColumn" {
            
            
            
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "importantCell"), owner: self) as? NSTableCellView {
                
                if toDoItem.important {
                    cell.textField?.stringValue = "‼️"
                } else {
                    cell.textField?.stringValue = ""
                }
                
                return cell
            }
            
        } else {
            
    // MARK: - To Do Column
            
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "todoitems"), owner: self) as? NSTableCellView {
                
                cell.textField?.stringValue = toDoItem.name!
                
                return cell
            }
        }
        return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        deleteButton.isHidden = false
        
    }
    
    
    
    
    
    
}
// MARK: - End of the document!!!
