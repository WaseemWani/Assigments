//
//  RecipesVCViewController.swift
//  CoreDataProject
//
//  Created by Waseem Wani on 07/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit
import CoreData

class RecipesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var recipeTab: UITabBarItem!
    @IBOutlet weak var tableView: UITableView!
    
     lazy var fetchedResultController: NSFetchedResultsController<Recipe> = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest = Recipe.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultController.delegate = self as? NSFetchedResultsControllerDelegate
        
        try! fetchResultController.performFetch()
        return fetchResultController
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//       // print()
//        print("url:\(url)")

        
        let nib = UINib(nibName: "RecipeViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RecipeViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        
        self.navigationController?.navigationBar.topItem?.title = "Recipes"
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let result = fetchedResultController.fetchedObjects else {return 0}
        recipeTab.badgeValue = String(result.count)
        return result.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeViewCell") as! RecipeViewCell
        let recipe = fetchedResultController.object(at: indexPath)
      
        cell.recNameLabel.text = recipe.name!
        cell.recMadeByLabel.text = "Made by: \(recipe.madeBy!)"
        cell.recCategorylabel.text = "Category: \(recipe.category!)"
        cell.ingredientsLabel.text = "Ingredients: \(recipe.recipeIngredients!)"

        //cell.descriptionLabel.text = "Description:\n\(recipe.recipeDescription!)"
//
//        //        if recipe.favorite == true {
//            cell.favouriteImage.image = UIImage(imageLiteralResourceName: "favT")
//        }
//        else {
//           cell.favouriteImage.image = UIImage(imageLiteralResourceName: "favF")
//        }
//
        return cell
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RecipesVC: NSFetchedResultsControllerDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // self.tableArray.remove(at: indexPath.row)
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate?.persistentContainer.viewContext
            let Myrecipe = fetchedResultController.object(at: indexPath)
            context!.delete(Myrecipe)
            try? context!.save()
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .delete {
            self.tableView.deleteRows(at: [indexPath!], with: .fade)
        }
        if type == .insert {
            let lastIndex = self.fetchedResultController.indexPath(forObject: anObject as! Recipe)
            tableView.insertRows(at: [lastIndex!], with: .fade)
        }
    }
    
}
