import UIKit
import AVFoundation


protocol EggTimerDelegate: AnyObject{
    func eggTimerDidUpdate(progress: Float, currentText: String)
    func eggTimerDidFinish(endText: String)
}


class EggTimer{
    weak var delegate: EggTimerDelegate?
    //SRP
    let eggTimes  = ["Soft" : 3, "Medium":4, "Hard":7]
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    
    func startTimer(for hardness:String){
        timer.invalidate() // bir işlem sırasında tekrardan diger butona o işlemi durdurup digerini baslatmak icin
        
        guard let time = eggTimes[hardness] else {return}
        totalTime = time
        secondsPassed = 0

        // belli zaman aralıgında tekrarlanan işlemler
        timer = Timer.scheduledTimer(
        timeInterval: 1.0,
        target: self,
        selector: #selector(update),
        userInfo: nil,
        repeats: true)
        
        
    }
    
    @objc private func update() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let progress = Float(secondsPassed) / Float(totalTime)
            delegate?.eggTimerDidUpdate(progress: progress, currentText: "...") // İsteğe bağlı metin
        } else {
            timer.invalidate()
            delegate?.eggTimerDidFinish(endText: "DONE!")
        }
    }
    
}

class ViewController: UIViewController {
    
    private let eggTimer = EggTimer()
    private let player = SoundPlayer()
        
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eggTimer.delegate = self
    }
    
    @IBAction func hardnessSelecter(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        progressBar.progress = 0.0
        eggTimer.startTimer(for: hardness)
        
    }
    
}

class SoundPlayer{
    var player: AVAudioPlayer!
    
    func playSound(soundName: Optional<String>) {
        let url = Bundle.main.url(forResource:soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
}
extension ViewController: EggTimerDelegate {
    
    func eggTimerDidUpdate(progress: Float, currentText: String) {
        // Gelen veriye göre SADECE UI'ı güncelliyor.
        progressBar.progress = progress
    }
    
    func eggTimerDidFinish(endText: String) {
        // Gelen veriye göre SADECE UI'ı güncelliyor ve diğer servisi çağırıyor.
        textLabel.text = endText
        player.playSound(soundName: "alarm_sound")
    }
}
