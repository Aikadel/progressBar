//
//  ViewController.swift
//  eggs
//
//  Created by Aigerim on 10.04.2022.
//

import UIKit
import AVFoundation

final class ViewController: UIViewController {
  
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
   
    var timer: Timer?
    var player: AVAudioPlayer?
    
    let eggSeconds: [String: Int] = ["Soft": 5, "Medium": 7, "Hard": 12]
    var seconds = 0
    let message = "How do you like your eggs?"
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 1
    }

    @IBAction func buttonTaping(_ sender: UIButton) {
        progressBar.progress = 0
        seconds = 0
        messageLabel.text = message
        timer?.invalidate()
        
        let currentSeconds = eggSeconds[sender.currentTitle!]
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            let result = 1.0 / Float(currentSeconds!)
            self.progressBar.progress += result
            self.seconds += 1
            if self.seconds == currentSeconds {
                timer.invalidate()
                self.messageLabel.text = "DONE"
                let path = Bundle.main.path(forResource: "alarm_sound", ofType: "mp3")
                let url = URL(string: path!)
                self.player = try? AVAudioPlayer(contentsOf: url!)
                self.player?.play()
            }
        }
    }
}
