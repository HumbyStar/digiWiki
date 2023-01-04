//
//  QuizViewController.swift
//  DigiWIki
//
//  Created by Humberto Rodrigues on 11/12/22.
//

import UIKit
import AVKit

class QuizViewController: UIViewController {
    
    @IBOutlet var btOptions: [UIButton]!
    @IBOutlet weak var lbAnswer: UILabel!
    
    @IBOutlet weak var viTimer: UIView!
    @IBOutlet weak var slMusic: UISlider!
    @IBOutlet weak var viSoundBar: UIView!
    
    var quizManager: QuizManager!
    
    var playItem: AVPlayerItem!
    var playMusic: AVPlayer!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quizManager = QuizManager()
        callMusicUrl()
        buildQuiz()
        formatTime()
    }

    func formatTime () {
        viTimer.frame = view.frame
        UIView.animate(withDuration: 60.0, delay: 0.0,options: .curveLinear) {
            self.viTimer.frame.size.width = 0
            self.viTimer.frame.origin.x = self.view.center.x
        } completion: { (success) in
            self.gameOver()
        }

    }
    
    func gameOver() {
        performSegue(withIdentifier: "gameOver", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ResultViewController
        vc.score = quizManager.score
    }
    
    func buildQuiz (){
        let quiz = quizManager.getRandomQuiz()
        lbAnswer.text = quiz.answer
        for i in 0..<quiz.options.count {
            btOptions[i].setTitle(quiz.options[i], for: .normal)
        }
        
    }
    
    @IBAction func selectAnswer(_ sender: UIButton) {
        quizManager.checkAnswer(sender.title(for: .normal)!)
        print("A view controller recebeu \(quizManager.score)")
        buildQuiz()
    }
    
    @IBAction func PlayandPause(_ sender: UIButton) {
        if playMusic.timeControlStatus == .paused {
            playMusic.play()
            sender.setImage(UIImage(named: "play"), for: .normal)
        } else {
            playMusic.pause()
            sender.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func ChangeMusicTime(_ sender: UISlider) {
        playMusic.seek(to: CMTime(seconds: Double(sender.value) * playItem.duration.seconds, preferredTimescale: 1))
    }
    
    func callMusicUrl(){
        let musicURL = Bundle.main.url(forResource: "music2", withExtension: "mp3")!
        playItem = AVPlayerItem(url: musicURL)
        playMusic = AVPlayer(playerItem: playItem)
        playMusic.volume = 1
        playMusic.play()
        playMusic.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: nil) { (time) in
            
            let singing = time.seconds / self.playItem.duration.seconds
            self.slMusic.setValue(Float(singing), animated: true)
        }
    }
    
    @IBAction func `return`(_ sender: UIBarButtonItem) {
        playMusic.pause()
        navigationController?.popViewController(animated: true)
    }
}
