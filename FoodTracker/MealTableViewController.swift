//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/15/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem

        // Load the sample data.
        loadSampleMeals()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*var rowcount = 0
        if section == 0 {
            rowcount = 3
        }
        if section == 1 {
            rowcount = meals.count
        }*/
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.number
        cell.titleLabel.text = meal.title
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    
    //MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }

    
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    //MARK: Private Methods
    
    private func loadSampleMeals() {
        
        let description1 = "Web concepts, infrastructure, development technologies, multi-tiered program design and implementation, and current issues and trends. "
        let description2 = "Theory and practice of state-of-the-art technologies for application development for the Web including service-oriented and mobile systems."
        
        let description3 = "Develop, deploy, and troubleshoot mobile and cloud computing applications. Prerequisite: Grade of C or better in IT 353, or consent of the school advisor."
        let description4 = "Intensive study of the Java programming language for students with previous programming experience. Not for credit if had IT 169, 178, 179, or 277. "
        let description5 = "Information systems development, development methodologies, analysis and design techniques and tools, relational database concepts. Prerequisites: Grade of C or better in IT (170, 178, or 179) and IT (254 or 225 or concurrent registration). Major or minor only or consent of the school advisor."
        let description6 = "Introduction to the design, evaluation, and understanding of qualitative and quantitative research methodologies. "
        let description7 = "Techniques for planning and supervising software development and infrastructure related projects, including defining project scope, allocating resources, projecting costs, and tracking project progress."
        let description8 = "Study of systems development life-cycle emphasizing current techniques for documenting users' requirements and producing maintainable, cost effective systems. Not for credit if IT 363 has already been taken. "
        let description9 = "Practical cryptography and its applications, authentication protocols, access controls and trusted systems. Formerly ADVANCED INFORMATION ASSURANCE AND APPLIED CRYPTOGRAPHY. Prerequisites: Grade of C or better in IT?250 or 226 and 276. Major or minor only or consent of the school advisor. "
        let description10 = "Design, configure, operate and use local area networks, network applications, and wide area network concepts. Emphasizes hands-on use of a network operating system. Prerequisites: Grade of C or better in IT 276. Major or minor only or consent of the school advisor. "

        guard let course1 = Meal(number: "IT353", title: "Web Development Technologies", description: description1) else {
            fatalError("Unable to instantiate meal1")
        }

        guard let course2 = Meal(number: "IT354", title: "Advanced Web Application Development", description: description2) else {
            fatalError("Unable to instantiate meal2")
        }

        guard let course3 = Meal(number: "IT358", title: "Mobile and Cloud Computing", description: description3) else {
            fatalError("Unable to instantiate meal2")
        }
        guard let course4 = Meal(number: "IT275", title: "Java As A Second Language", description: description4) else {
            fatalError("Unable to instantiate course 4")
        }
        
        guard let course5 = Meal(number: "IT261", title: "Systems Development I", description: description5) else {
            fatalError("Unable to instantiate course 5")
        }
        
        guard let course6 = Meal(number: "IT497", title: "Introduction To Research Methodology", description: description6) else {
            fatalError("Unable to instantiate course 6")
        }
        guard let course7 = Meal(number: "IT463", title: "Information Technology Project Management", description: description7) else {
            fatalError("Unable to instantiate course 7")
        }
        
        guard let course8 = Meal(number: "IT432", title: "System Analysis and Design", description: description8) else {
            fatalError("Unable to instantiate course 8")
        }
        
        guard let course9 = Meal(number: "IT351", title: "Practical Cryptography and Trusted Systems", description: description9) else {
            fatalError("Unable to instantiate Course 9")
        }
        guard let course10 = Meal(number: "IT377", title: "Practical Telecommunication Networking", description: description10) else {
            fatalError("Unable to instantiate Course 10")
        }

        meals += [course5, course4, course9, course1, course2, course10, course3, course8, course7, course6]
        
    }
}
