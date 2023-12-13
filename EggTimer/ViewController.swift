//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let eggTimes  = ["Soft" : 10, "Medium":420, "Hard":720]
    
    var seconds = 60
    var timer = Timer()
    
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBAction func hardnessSelecter(_ sender: UIButton) {
        
        timer.invalidate() // bir işlem sırasında tekrardan diger butona o işlemi durdurup digerini baslatmak icin
        let hardness = sender.currentTitle!
        
        seconds = eggTimes[hardness]!
        
        // belli zaman aralıgında tekrarlanan işlemler
        timer = Timer.scheduledTimer(
        timeInterval: 1.0,
        target: self,
        selector: #selector(updateCounter),
        userInfo: nil,
        repeats: true)
        
        
    }
    
    @objc func updateCounter(){
        if seconds>0{
            print("\(seconds) seconds")
            seconds -= 1
        }
        else{
            timer.invalidate()
            textLabel.text = "DONE!"
        }
    }
}

