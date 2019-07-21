//
//  MealTableViewController.swift
//  FirstApplicationRepo
//
//  Created by Srinivasa Ravi Teja Peri on 7/19/19.
//  Copyright © 2019 HarshaRaviGitHub. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    var meals = [Meal] ()
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue)
    {
        if let sourceViewController = sender.source as? ViewController, let meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                let newIndexPath = IndexPath(row: meals.count, section: 0);
                meals.append(meal);
                tableView.insertRows(at: [newIndexPath], with:.automatic)
            }
        }
    }
    
    private func loadSampleMeals()
    {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal(name: "Caprese", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal(name: "Salad", photo: photo2, rating: 3) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Meal(name: "chips", photo: photo3, rating: 2) else {
            fatalError("Unable to instantiate meal3")
        }
        
        meals += [meal1, meal2, meal3]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleMeals()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("did not return a mealtableviewcell)")
        }
        
        let meal = meals[indexPath.row]
        
        cell.photoImageView.image = meal.photo
        cell.nameLabel.text = meal.name
        cell.ratingControl.rating = meal.rating
        
        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "AddItem":
        os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        
        case "ShowDetail":
        guard let mealDetailViewController = segue.destination as? ViewController else {
            fatalError("Unexpected destination")
        }
        
        guard let selectedMealCell = sender as? MealTableViewCell else {
            fatalError("Unexpected sender")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedMeal = meals[indexPath.row]
        mealDetailViewController.meal = selectedMeal
        
        default:
            fatalError("Unexpected Segue Identifier");
        }
    }


}
