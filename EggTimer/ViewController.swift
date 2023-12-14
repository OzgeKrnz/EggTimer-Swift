import UIKit

class ViewController: UIViewController {
    
    let eggTimes  = ["Soft" : 3, "Medium":4, "Hard":7]
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    @IBAction func hardnessSelecter(_ sender: UIButton) {
        
    
        timer.invalidate() // bir işlem sırasında tekrardan diger butona o işlemi durdurup digerini baslatmak icin
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        textLabel.text = hardness
        // belli zaman aralıgında tekrarlanan işlemler
        timer = Timer.scheduledTimer(
        timeInterval: 1.0,
        target: self,
        selector: #selector(updateCounter),
        userInfo: nil,
        repeats: true)
        
        
    }
    
    @objc func updateCounter(){
        if secondsPassed < totalTime{
            secondsPassed += 1

            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        }
        else{
            timer.invalidate()
            textLabel.text = "DONE!"
        }
    }
}

