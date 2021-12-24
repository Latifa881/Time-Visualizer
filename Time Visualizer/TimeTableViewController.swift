//
//  TimeTableViewController.swift
//  Time Visualizer
//
//  Created by administrator on 23/12/2021.
//

import UIKit
import CoreData

class TimeTableViewController: UITableViewController , TaskDelegate {
    
    func taskSaved(by controller: CustomTableViewCell, withTasks tasks: [EventEntity]) {
        
        fetchAllItemsCoreData()
        for i in tasksDetails{
            print(i.day,i.hour,i.task)
            
        }
       
    }
    
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tasksDetails = [EventEntity]()
    
    let daysOfWeek:[String] = ["Sun","Mon","Tues", "Wed", "Thurs", "Friday","Sat"]
    
    let hours = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20, 21,22,23,24]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        fetchAllItemsCoreData()
//Delete
//        for item in tasksDetails{
//               managedObjectContext.delete(item)
//
//               do {
//                   try managedObjectContext.save()
//
//               }catch{
//                   print(error.localizedDescription)
//               }
//
//        }
    }
    @IBAction func progressButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "chart", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        let destination = navigationController.topViewController as! ChartsViewController
        fetchAllItemsCoreData()

         destination.tasksDetails = tasksDetails

         
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 7
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return daysOfWeek[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 24
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! CustomTableViewCell
        
        cell.hourLabel.text = "\(hours[indexPath.row])"
        
        for detail in tasksDetails {
            if detail.day ==  daysOfWeek[indexPath.section] && detail.hour == String(hours[indexPath.row]) {
                cell.taskTextField.text = detail.task
                break
            }else{
                cell.taskTextField.text = ""
            }
        }
        
    
        cell.day = daysOfWeek[indexPath.section]
        
        cell.mainStack.layer.cornerRadius=10
        cell.mainStack.clipsToBounds=true
        cell.mainStack.backgroundColor = .purple.withAlphaComponent(0.3)
        cell.taskTextField.backgroundColor = .purple.withAlphaComponent(0.1)
       
        return cell
    }
    
   
    func fetchAllItemsCoreData(){
        
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EventEntity")
        do {
            let results = try managedObjectContext.fetch(itemRequest)
            tasksDetails = results as! [EventEntity]
          
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
    }




/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

}

