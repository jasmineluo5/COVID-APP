//
//  HomeController.swift
//  covidApp
//
//  Created by Mark Qiao on 6/17/21.
//

import UIKit

class HomeController: UIViewController {
    
    let quoteArray = ["Laziness may appear attractive, but work gives satisfaction.", "The opportunity of defeating the enemy is provided by the enemy himself", "Be the CHANGE that you wish to see in the world.","The best view comes after the hardest climb", "After darkness there always comes light - but we must wait to see it"]

    @IBOutlet weak var lblQuote: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblQuote.numberOfLines = 0
        lblQuote.text = quoteArray.randomElement()
        // Do any additional setup after loading the view.
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
