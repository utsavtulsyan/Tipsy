//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var splitAmount = ""
    var settings = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        dismissKeyboard()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        dismissKeyboard()
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = Float( billTextField.text ?? "0" ) ?? 0
        let people = Float( splitNumberLabel.text ?? "0" ) ?? 0
        splitAmount = String(format: "%.2f", (1 + getSelectedPct()) * bill / people )
        settings = "Split Between \(Int(people)) people, with \(getSelectedPct())% tip."
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    
    
    func getSelectedPct() -> Float {
        if(zeroPctButton.isSelected){
            return 0
        }else if(tenPctButton.isSelected){
            return 0.1
        }else{
            return 0.2
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "goToResult") {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.splitAmount = splitAmount
            destinationVC.settings = settings
            
        }
        
    }

}

