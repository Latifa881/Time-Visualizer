//
//  CustomTableViewCell.swift
//  Time Visualizer
//
//  Created by administrator on 23/12/2021.
//

import UIKit
import CoreData

class CustomTableViewCell: UITableViewCell {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasksDetails = [EventEntity]()
    
    @IBOutlet weak var hourLabel : UILabel!
    @IBOutlet weak var taskTextField : UITextField!
    @IBOutlet weak var mainStack : UIStackView!
    
    var indexPath: IndexPath?
    var delegate: TaskDelegate?
    var day:String?
    
    @IBAction func AddButtonPressed(_ sender: UIButton){
        
        guard let task = taskTextField.text else {return}
        guard let hour = hourLabel.text else {return}
        guard let day = day else {return}
        
       
        let thing = NSEntityDescription.insertNewObject(forEntityName: "EventEntity", into: managedObjectContext) as! EventEntity
            
        thing.task = task
        thing.hour = hour
        thing.day = day
        
        print("task \(task)")
        print("hour \(hour)")
        print("day \(day)")
        
        tasksDetails.append(thing)
        
        
        if managedObjectContext.hasChanges{
            do {
                try managedObjectContext.save()
                
            }catch{
                print(error.localizedDescription)
            }
        }
       
   
        delegate?.taskSaved(by: self, withTasks: tasksDetails)
    }
}
