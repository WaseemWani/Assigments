//
//  AddRecipesVC.swift
//  CoreDataProject
//
//  Created by Waseem Wani on 07/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit
import CoreData

class AddRecipesVC: UIViewController {

    @IBOutlet weak var categoryTxtField: UITextField!
    @IBOutlet weak var ingredientsTxtField: UITextField!
    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var recipeMadeByTxtfield: UITextField!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var addTofavoritesSwitch: UISwitch!
    
    override func viewDidLoad() {
        self.navigationItem.title = "Add Recipes"
        navigationItem.backBarButtonItem?.isEnabled = false
        navigationItem.hidesBackButton = false
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}


extension AddRecipesVC {
    
    @IBAction func saveRecipeBtnTapped() {
        
        addRecipes()
    
        // this will push TabBarController
        let storyObj = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyObj.instantiateViewController(withIdentifier: "TabBarVc") as? TabBarVc
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel() {
        self.navigationController?.popViewController(animated: true)
        //dismiss(animated: true, completion: nil)
    }
    
    func addRecipes() {
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            if let context = appDelegate?.persistentContainer.viewContext {
                let entity = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: context) as? Recipe
                entity?.category = categoryTxtField.text!
                entity?.name = recipeName.text!
                entity?.recipeIngredients = ingredientsTxtField.text!
                entity?.madeBy =  recipeMadeByTxtfield.text!
                entity?.recDescription = descriptionTxtView.text!
                entity?.favorite = addTofavoritesSwitch.isOn
                
                appDelegate?.saveContext()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


