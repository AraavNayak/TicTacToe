//
//  IntroViewController.swift
//  TicTacToe
//
//  Created by Araav Nayak on 4/24/22.
//

import UIKit

class IntroViewController: UIViewController {
   
    
    
    
    
    var onePlayer:Bool = true
    
    
    
    
    
    @IBAction func TwoButton(_ sender: UIButton) {
        //onePlayer = false
        //performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    //segue needed for 1/2 plsyer
    
    @IBAction func OneButton(_ sender: UIButton) {
        //onePlayer = true
        //performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ViewController
            destinationVC.op = onePlayer
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}
