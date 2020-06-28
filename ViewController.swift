//
//  ViewController.swift
//  Random-Restaurant
//
//  Created by 山下将司 on 5/16/20.
//  Copyright © 2020 mashi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    
    var audioPlayer = AVAudioPlayer()
    let audioPath = Bundle.main.bundleURL.appendingPathComponent("test.mp3")
    
    func go() {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: audioPath, fileTypeHint: nil)
            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            
        } catch {
            print("オープニングエラーです。")
        }
    }

    var img00 :UIImage = UIImage(named:"0")!
    var img01 :UIImage = UIImage(named:"1")!
    var img02 :UIImage = UIImage(named:"2")!
    var img03 :UIImage = UIImage(named:"3")!
    var img04 :UIImage = UIImage(named:"4")!
    var img05 :UIImage = UIImage(named:"5")!
    var img06 :UIImage = UIImage(named:"6")!
    var img07 :UIImage = UIImage(named:"7")!
    var img08 :UIImage = UIImage(named:"8")!
    var img09 :UIImage = UIImage(named:"9")!
    var img10 :UIImage = UIImage(named:"10")!
    var img11 :UIImage = UIImage(named:"11")!
    var img12 :UIImage = UIImage(named:"12")!
    var img13 :UIImage = UIImage(named:"13")!
    var img14 :UIImage = UIImage(named:"14")!
    var img15 :UIImage = UIImage(named:"15")!
    var img16 :UIImage = UIImage(named:"16")!
    var img17 :UIImage = UIImage(named:"17")!
    var img18 :UIImage = UIImage(named:"18")!
    var img19 :UIImage = UIImage(named:"19")!
    var img20 :UIImage = UIImage(named:"20")!
    var img21 :UIImage = UIImage(named:"21")!
    var img22 :UIImage = UIImage(named:"22")!
    var img23 :UIImage = UIImage(named:"23")!
    var img24 :UIImage = UIImage(named:"24")!
    var img25 :UIImage = UIImage(named:"25")!
    var img26 :UIImage = UIImage(named:"26")!
    var img27 :UIImage = UIImage(named:"27")!
    var img28 :UIImage = UIImage(named:"28")!
    var img29 :UIImage = UIImage(named:"29")!
    
    
    var meigen1 :String = ("悩みはあって当たり前。それは生きている証。")
    var meigen2 :String = ("悩みによってはじめて知恵は生まれる。悩みがないところに知恵は生まれない。")
    var meigen3 :String = ("悩みに気持ちが奪われてる時間がもったいない。")
    var meigen4 :String = ("動かないと、悩みってずっとそのままになっちゃう。")
    var meigen5 :String = ("前に進もうとするから、迷い、悩み、感じ、気付き、生まれ、変われるんだ。")
    var meigen6 :String = ("大丈夫だ。心配するな。なんとかなる。")
    var meigen7 :String = ("笑われて笑われて強くなるんだよ。")
    var meigen8 :String = ("何か困ったことや悩み事があって、それが困難な問題であればあるほど「あたりまえのこと」から始める。")
    var meigen9 :String = ("人生は一度きりだから生まれ変わるなら生きているうちに。")
    var meigen10 :String = ("時間が多くのことを解決してくれる。あなたの今日の悩みも解決してくれるに違いない。")
    var meigen11 :String = ("「悩み」とは すなわち向上したい思い。")
    var meigen12 :String = ("つまづいたっていいじゃないか にんげんだもの。")
    var meigen13 :String = ("必死に生きてこそ、その生涯は光を放つ。")
    var meigen14 :String = ("悩みや迷いが吹っ切れない時は、行動して解決にあたりなさい。")
    var meigen15 :String = ("成功する秘訣は、成功するまで失敗しつづけることである。")
    var meigen16 :String = ("今日できることを、明日に延ばすな。今日それを片付ければ、明日はそれが楽しみになる。")
    var meigen17 :String = ("決定を下すときに、「他の人はどう思うだろうか」ではなく「自分は自分自身をどう思うのか」と問うようにしましょう。")
    var meigen18 :String = ("決断するとは「悩む」のではなく「決める」こと。")
    var meigen19 :String = ("大文字ばかりで印刷された書物は読みにくい。 日曜日ばかりの人生もそれと同じだ。")
    var meigen20 :String = ("小さなことで満足することっていうのはすごく大事なこと。")
    var meigen21 :String = ("失敗を重ねることって大事。")
    
    
    var imgArray:[UIImage] = []
    
    var meigenArray:[String] = []
//画面起動時にをimageを動かす
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // 角丸設定
            self.button.layer.cornerRadius = 12
            
            // 背景色
        self.button.backgroundColor = UIColor.red
            
            // 影の設定
            self.button.layer.shadowOpacity = 0.5
            self.button.layer.shadowRadius = 12
            self.button.layer.shadowColor = UIColor.black.cgColor
            self.button.layer.shadowOffset = CGSize(width: 5, height: 5)
            
        //viewが立ち上がった時に音楽を自動再生する。
        self.go()
        
        imgArray = [img00,img01,img02,img03,img04,img05,img06,img07,img08,img09,img10,img11,img12,img13,img14,img15,img16,img17,img18,img19,img20,img21,img22,img23,img24,img25,img26,img27,img28,img29,img29]
        let ret = Int(arc4random_uniform(30))
        imageView.image = imgArray[ret]
        
        meigenArray = [meigen1,meigen2,meigen3,meigen4,meigen5,meigen6,meigen7,meigen8,meigen9,meigen10,meigen11,meigen12,meigen13,meigen14,meigen15,meigen16,meigen17,meigen18,meigen19,meigen20,meigen21]
        let meigen = Int(arc4random_uniform(21))
        
        label.lineBreakMode = .byWordWrapping
        label.text = meigenArray[meigen]

        label.numberOfLines = 0
    }
        

    @IBAction func gohan(_ sender: Any) {
        audioPlayer.stop()
    }
    
}
