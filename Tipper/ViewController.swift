//
//  ViewController.swift
//  Tipper1
//
//  Created by Kevin Denis on 9/29/19.
//  Copyright © 2019 Kevin Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalTipLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var billTotalLabel: UILabel!
    @IBOutlet weak var splitTotalLabel: UILabel!
    @IBOutlet weak var groupSlider: UISlider!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var hiddentextLabel: UILabel!
    @IBOutlet weak var defaultTipField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaultTip = UserDefaults.standard.float(forKey: "tipKey")
        if billField != nil {
        self.billField.becomeFirstResponder()
        tipSlider.value = defaultTip
        viewPercent(tipSlider)
        
        }
        if defaultTipField != nil {
            defaultTipField.text = "\(defaultTip)"
        }
        
    }
    
    @IBAction func setDefaultTip(_ sender: Any) {
        let defaults = UserDefaults.standard
        let defaultTip = Float(defaultTipField.text!) ?? 15
        defaults.set(defaultTip, forKey: "tipKey")
        defaults.synchronize()
        
        print("Defualt tip set to \(defaultTip)")
        
        if defaultTipField.text == "" {
            defaultTipField.text = "15"
        }
        
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       return .portrait
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Generating a random, reasonable tip amount. Perhaps the waiter also had a terrible day :(")
            let randomTip = Int.random(in: 10 ..< 19)
            tipSlider.value = Float(randomTip)
            calculateTip(tipSlider)
            //these two lines were a guess but seem to have worked
            viewPercent(tipSlider)
            print(tipSlider.value)
        }
    }
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func resetTextField(_ sender: Any) {
        if billField.text == "" {
            billField.text = "BILL"
            billField.clearsOnBeginEditing = true
        }
    }
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billField.text!) ?? 0
        let tip = bill * Double(floorf(tipSlider.value)/100)
        let split = Int(groupSlider.value)
        let total = (bill + tip)
        let personTotal = (bill + tip) / Double(split)
        
        totalTipLabel.text = String(format: "$%.2f" , tip)
        billTotalLabel.text = String(format: "$%.2f" , total)
        splitTotalLabel.text = String(format: "$%.2f" , personTotal)
    }
    
    @IBAction func viewPercent(_ sender: Any) {
        let percent = Int(tipSlider.value)
        percentageLabel.text = "\(percent)" + "%"
    }
    @IBAction func viewGroupSize(_ sender: Any) {
        let groupSize = Int(groupSlider.value)
        groupLabel.text = "\(groupSize)"
    }
    @IBAction func revealAppreciation(_ sender: Any) {
        let billValue = Int(billField.text!) ?? 0
        if tipSlider.value >= 20 && billValue >= 200 {
            hiddentextLabel.text = "Whoa, that's a big tip!"
        }else if tipSlider.value >= 20 && billValue >= 5 {
            hiddentextLabel.text = "Your generosity will surely be appreciated :)"
        }else {
            hiddentextLabel.text = ""
        }
    }
    
}


