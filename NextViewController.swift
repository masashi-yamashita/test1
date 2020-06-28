//
//  NextViewController.swift
//  Random-Restaurant
//
//  Created by 山下将司 on 5/16/20.
//  Copyright © 2020 mashi. All rights reserved.
//

import UIKit
import AVFoundation

class NextViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    
    var timer = Timer()
    var count = Int()
    var imageArray = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // startButton角丸設定
        self.startButton.layer.cornerRadius = 12
            
        // 背景色
        self.startButton.backgroundColor = UIColor.green
            
        // 影の設定
        self.startButton.layer.shadowOpacity = 0.5
        self.startButton.layer.shadowRadius = 12
        self.startButton.layer.shadowColor = UIColor.black.cgColor
        self.startButton.layer.shadowOffset = CGSize(width: 5, height: 5)
          

        // stopButton角丸設定
        self.stopButton.layer.cornerRadius = 12
            
        // 背景色
        self.stopButton.backgroundColor = UIColor.red
            
        // 影の設定
        self.stopButton.layer.shadowOpacity = 0.5
        self.stopButton.layer.shadowRadius = 12
        self.stopButton.layer.shadowColor = UIColor.black.cgColor
        self.stopButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        
        // searchButton角丸設定
        self.searchButton.layer.cornerRadius = 12
            
        // 背景色
        self.searchButton.backgroundColor = UIColor.orange
            
        // 影の設定
        self.searchButton.layer.shadowOpacity = 0.5
        self.searchButton.layer.shadowRadius = 12
        self.searchButton.layer.shadowColor = UIColor.black.cgColor
        self.searchButton.layer.shadowOffset = CGSize(width: 5, height: 5)
          
        
// 最初の画面で表示する画像=ラーメン=0
        
        count = 0
        
//stopボタンを押せなくする。
        stopButton.isEnabled = false
        
        for i in 0..<30{
            print(i)
            

        let image = UIImage(named: "\(i)")
            imageArray.append(image!)
            
        }
        imageView.image = UIImage(named: "0")
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func timerUpdate(){
        repeat {
        count = Int.random(in: 0..<30)
            
        imageView.image = imageArray[count]
        
//        countが100になるまで繰り返し＝無限に繰り返し！！
        } while count == 100
    }
    
    var startPlayer = AVAudioPlayer()
    let startPath = Bundle.main.bundleURL.appendingPathComponent("natsuhasummer.mp3")
    

    @IBAction func start(_ sender: Any) {

        
        startTimer()
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        do {
        startPlayer = try AVAudioPlayer(contentsOf: startPath, fileTypeHint: nil)
        startPlayer.play()
        startPlayer.numberOfLoops = -1
        startPlayer.prepareToPlay()
        stopPlayer.stop()
            
        } catch {
            print("start音源でエラー")
        }
        
    }
    
    var stopPlayer = AVAudioPlayer()
    let stopPath = Bundle.main.bundleURL.appendingPathComponent("歓声と拍手1.mp3")
    
    @IBAction func stop(_ sender: Any) {
        
        stopButton.isEnabled = false
        startButton.isEnabled = true
        timer.invalidate()
        
        do {
        stopPlayer = try AVAudioPlayer(contentsOf: stopPath, fileTypeHint: nil)
            stopPlayer.play()
            startPlayer.stop()
            
        } catch {
            print("stopでエラー")
        }

    }
}
