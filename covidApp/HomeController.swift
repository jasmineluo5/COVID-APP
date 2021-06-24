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
    @IBOutlet weak var heartImage: UIImageView!
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        lblQuote.numberOfLines = 2
        lblQuote.text = quoteArray.randomElement()
        heartImage.layer.cornerRadius = heartImage.frame.size.width/2
        heartImage.clipsToBounds = true
        heartImage.layer.borderColor = UIColor.black.cgColor
        heartImage.layer.borderWidth = 4;
        getStartedButton.layer.cornerRadius = 8
//        let testButton = GradientButton(frame:CGRect(x:0,y:0, width:220, height:50))
//        view.addSubview(testButton)
//        testButton.center = view.center
//        testButton.setTitle("TEST", for: .normal)
//        testButton.layer.cornerRadius = 8
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
