//
//  ViewController.swift
//  memory
//
//  Created by ANATOLI DIMITROV KOUEMO NGAYO on 2020/4/4.
//  Copyright © 2020 AnatDim. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet var birdView : UIImageView! // Maniac Flamingo View
    @IBOutlet var timeCountLabel : UILabel!// Time Counter
    @IBOutlet var congratulationView : UIImageView!// Win View
    
    @IBOutlet var soundButtonImage: UIButton! // Sound Button Image
    @IBOutlet var refreshButtonImage: UIButton! // Refresh Button Image
    
    @IBOutlet var middleView: UIView!
    var contrary1 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary2 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary3 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary4 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary5 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary6 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary7 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary8 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary9 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary10 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary11 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary12 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary13 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary14 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary15 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary16 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary17 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary18 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary19 = MyImageView(image: UIImage(named: "iconQ"))
    var contrary20 = MyImageView(image: UIImage(named: "iconQ"))
    
    @IBOutlet var topView: UIStackView!
    
    var bgPlayer :AVAudioPlayer!// Background Music
    var clickPlayer :AVAudioPlayer!// Click Sound Effect
    var doublePlayer : AVAudioPlayer!// Bingo Sound Effect
    var winPlayer : AVAudioPlayer!// Win Audio Effect
    var lowTimePlayer : AVAudioPlayer!// Low Time Audio Effect
    var failPlayer : AVAudioPlayer!// Fail Audio Effect
    var timer : Timer!// Timer
    var secondsLeft :String = "0"//The variable we will store the remaining time
    var doubleCount :Int = 0// Mactch Pair
    var isGameOver :Bool = false// End Game
    var tempImageView :MyImageView!// First Time Click Temporary View
    @IBOutlet var bgImageView: UIImageView! // Background Image View
    
    @IBAction func doMusic(sender : UIButton)
    {
        // Play Background Melody
        if (self.bgPlayer.isPlaying)
        {
            self.bgPlayer.stop()
            sender.setImage(UIImage(named:"orangeMute"), for: .normal)
        }
        else
        {
            self.bgPlayer.play()
            sender.setImage(UIImage(named:"orangeVol"), for: .normal)
        }
    }
    // Refresh Button
    @IBAction func doRefresh(sender : UIButton?)
    {
        if (self.lowTimePlayer.isPlaying)
        {
            self.lowTimePlayer.stop()
        }
        if (self.failPlayer.isPlaying)
        {
            self.failPlayer.stop()
        }
        self.bgPlayer.play()
        soundButtonImage.setImage(UIImage(named:"orangeVol"), for: .normal)
        
        self.timeCountLabel.text = "60"
        self.doubleCount = 0
        self.birdView.startAnimating()
        self.tempImageView = nil
        if(isGameOver || timer == nil)
        {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeCount), userInfo: nil, repeats: true)
            self.birdView.startAnimating()
            self.isGameOver = false
        }
        self.loadFruits()
        self.turnAll2Left()
        self.congratulationView.isHidden=true
        
        congratulationView.translatesAutoresizingMaskIntoConstraints = false
        congratulationView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10).isActive = true
        congratulationView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        congratulationView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        congratulationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.turnAll2Right()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pauseBgMusic()
        pauseTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if (self.lowTimePlayer.isPlaying)
        {
            self.lowTimePlayer.stop()
        }
        if (self.failPlayer.isPlaying)
        {
            self.failPlayer.stop()
        }
        if (self.bgPlayer.isPlaying)
        {
            self.bgPlayer.stop()
        }
        if (self.winPlayer.isPlaying)
        {
            winPlayer.stop()
        }
        timer.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resumeBgMusic()
        resumeTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func pauseTimer()
    {
        //Get the difference in seconds between now and the future fire date
        secondsLeft = timeCountLabel.text!
        //Stop the timer
        timer.invalidate()
    }
    
    @objc func resumeTimer()
    {
        if (self.isGameOver == false && Int(secondsLeft)! > 0) {
            //Start the timer again with the previously time left
            self.timeCountLabel.text = secondsLeft
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeCount), userInfo: nil, repeats: true)
        }
    }
    
    @objc func pauseBgMusic() {
        bgPlayer.pause()
        soundButtonImage.setImage(UIImage(named:"orangeMute"), for: .normal)
        if (self.lowTimePlayer.isPlaying) {
            lowTimePlayer.pause()
        }
        if (self.failPlayer.isPlaying) {
            failPlayer.pause()
        }
        if (self.winPlayer.isPlaying) {
            winPlayer.pause()
        }
    }
    
    @objc func resumeBgMusic() {
        if (self.isGameOver == false) {
            if (!bgPlayer.isPlaying) {
            bgPlayer.play()
            soundButtonImage.setImage(UIImage(named:"orangeVol"), for: .normal)
            }
            // If timer was below 10 then resume low time player
            let remTimeAtForeGr:Int? = Int(timeCountLabel.text!)
            if (remTimeAtForeGr! <= 10) {
                if (!lowTimePlayer.isPlaying) {
                self.lowTimePlayer.play()
                }
            }
        }
        
        if (self.isGameOver == true) {
            if (self.bgPlayer.isPlaying) {
                bgPlayer.stop()
                soundButtonImage.setImage(UIImage(named:"orangeMute"), for: .normal)
            }
        }
    }
    
    func loadFruits()
    {
        let tags = randomTags()
        let images = randomImages()
        var index = 0
        for i in 0...9
        {
            // Pick an Item
            let image:UIImage = images[i] as! UIImage
            // Get Two iconQs
            let my1:MyImageView = self.view.viewWithTag( tags[index] as! Int) as! MyImageView
            index+=1
            let my2:MyImageView = self.view.viewWithTag( tags[index] as! Int) as! MyImageView
            index+=1
            // Set and Mark Same Item
            my1.myImage = image
            my2.myImage = image
            my1.myTag = i
            my2.myTag = i
        }
        
    }
    func randomTags()->NSArray
    {
        let mArr:NSMutableArray =  NSMutableArray()
        while(mArr.count < 20)
        {
            let tag = arc4random()%20+100
            let t = NSNumber(value: tag)
            if(!mArr.contains(t))
            {
                mArr.add(t)
            }
        }
        return mArr
    }
    func randomImages()->NSArray
    {
        let images = NSMutableArray()
        while(images.count < 10)
        {
            let i = arc4random()%18+1
            let image:UIImage = UIImage(named: "item\(i).png")!
            if(!images.contains(image))
            {
                images.add(image)
            }
        }
        return images
    }
    func turnAll2Left()
    {
        for i in 100...119
        {
            let myI  = self.view.viewWithTag(i) as! MyImageView
            myI.turn2Left()
        }
    }
    func turnAll2Right()
    {
        for i in 100...119
        {
            let myI  = self.view.viewWithTag(i) as! MyImageView
            myI.turn2Right()
        }
    }
    func loadMusicByName(name : String)->AVAudioPlayer?
    {
        let path = Bundle.main.path(forResource: name,ofType: "mp3")
        let url = NSURL.fileURL(withPath: path!)
        do {
            let player = try AVAudioPlayer(contentsOf: url,fileTypeHint: nil)
            player.prepareToPlay()
            player.volume = 0.9
            return player
        }
        catch{
            
        }
        return nil;
    }
    func prepareMusic()
    {
        self.bgPlayer = loadMusicByName(name: "bg")
        self.bgPlayer.numberOfLoops = -1
        self.clickPlayer = loadMusicByName(name: "click")
        self.doublePlayer = loadMusicByName(name: "double")
        self.winPlayer = loadMusicByName(name: "confetti")
        self.lowTimePlayer = loadMusicByName(name: "lowTime4")
        self.failPlayer = loadMusicByName(name: "fail")
        self.bgPlayer.prepareToPlay()
        self.bgPlayer.volume = 0.8
        self.clickPlayer.prepareToPlay()
        self.clickPlayer.volume = 0.5
        self.doublePlayer.prepareToPlay()
        self.doublePlayer.volume = 0.5
        self.winPlayer.prepareToPlay()
        self.lowTimePlayer.prepareToPlay()
        self.lowTimePlayer.numberOfLoops = -1
        self.failPlayer.prepareToPlay()
    }
    func prepareBird()
    {
        let images :NSMutableArray = NSMutableArray()
        for i in 1...7
        {
            let str = "f\(i).png"
            let image = UIImage(named: str)
            images.add(image!)
        }
        self.birdView.animationImages = images  as? [UIImage]
        self.birdView.animationDuration = 1.2
    }
    func prepareTimeCount()
    {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeCount), userInfo: nil, repeats: true)
    }
    
    func prepareWinView()
    {
        let images:NSMutableArray! = NSMutableArray()
        for i in 1...12
        {
            let image = UIImage(named:"win\(i).png")
            images.add(image!)
        }
        
        self.congratulationView.animationImages = images as [AnyObject] as? [UIImage]
        self.congratulationView.animationDuration = 3
        self.congratulationView.startAnimating()
        self.view.addSubview(self.congratulationView)
    }
    @objc func timeCount()
    {
        var timeCount = Int(self.timeCountLabel!.text!) ?? 0
        if (timeCount <= 11) {
            self.lowTimePlayer.play()
        }
        if(timeCount <= 0 )
        {
            if (self.lowTimePlayer.isPlaying)
            {
                self.lowTimePlayer.stop()
            }
            
            self.timer.invalidate()
            self.gameOver()
        }
        else
        {
            timeCount-=1
        }
        self.timeCountLabel.text = String(timeCount)
    }
    func gameOver()
    {
        self.isGameOver = true
        if (self.bgPlayer.isPlaying)
        {
            self.bgPlayer.stop()
            soundButtonImage.setImage(UIImage(named:"orangeMute"), for: .normal)
            bgPlayer.currentTime = 0
        }
        if (self.lowTimePlayer.isPlaying) {
            self.lowTimePlayer.stop()
        }
        self.failPlayer.play()
        self.birdView.stopAnimating()
        self.timer.invalidate()
        
        let alert : UIAlertController! = UIAlertController(title: "Watch Out", message: "Time's Up!", preferredStyle: .alert)
        // Change font and color of title
        alert.setTitleText(font: UIFont.boldSystemFont(ofSize: 26), color: Colors.coolWhite)
        // Change font and color of message
        alert.setMessage(font: UIFont(name: "AvenirNextCondensed-HeavyItalic", size: 18), color: Colors.coolRed)
        // Change background color of UIAlertController
        alert.setBackgroundColor(color: Colors.coolBlue, borderWidth: 10.0, borderColor: Colors.coolGreen.cgColor)
        let alertAction :UIAlertAction = UIAlertAction(title:"Try Again!",style:.default,handler:  {
            (UIAlertAction)->Void in self.doRefresh(sender: nil)
        })
        alertAction.setValue(Colors.coolOrange, forKey: "TitleTextColor")
//        alertAction.setTitleText(font: UIFont(name: "AvenirNextCondensed-HeavyItalic", size: 18), color: UIColor.systemPink)
        alert.addAction(alertAction)
        self.present(alert,animated: true,completion: nil)
        
    }
    func gameWin()
    {
        self.isGameOver = true
        self.winPlayer.play()
        if (self.lowTimePlayer.isPlaying) {
            self.lowTimePlayer.stop()
        }
        self.birdView.stopAnimating()
        self.congratulationView.isHidden = false
        self.timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgImageView = UIImageView(image: UIImage(named: "v1Bkgrd-2048x1536"))
        bgImageView.contentMode = .scaleAspectFill
        self.view.addSubview(bgImageView)
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bgImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -0).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -0).isActive = true
        self.prepareMusic()
        setupTopView()
        self.prepareTimeCount()
        setupMiddleView()
        setupBottomView()
        self.prepareBird()
        self.prepareWinView()
        self.doRefresh(sender: nil)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(pauseTimer), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(pauseBgMusic), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(resumeTimer), name: UIApplication.didBecomeActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(resumeBgMusic), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func setupTopView() {
        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
                topView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 10).isActive = true
                topView.leftAnchor.constraint(lessThanOrEqualTo: view.leftAnchor, constant: 10).isActive = true
                topView.rightAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor, constant: -10).isActive = true
                topView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        // created a view and make it a circle and then added the label inside to design the timer. Here is the code :
        let size:CGFloat = 74
        let labelView = UIView()
        labelView.layer.cornerRadius = size/2
        labelView.backgroundColor = Colors.coolGreen
        labelView.layer.borderColor = Colors.coolOrange.cgColor
        labelView.layer.borderWidth = 10
        labelView.layer.shadowColor   = UIColor.black.cgColor
        labelView.layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
        labelView.layer.shadowRadius  = 8
        labelView.layer.shadowOpacity = 0.5
        labelView.clipsToBounds       = true
        labelView.layer.masksToBounds = true
        
        topView.addSubview(labelView)
        
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        labelView.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        labelView.heightAnchor.constraint(equalToConstant: size).isActive = true
        labelView.widthAnchor.constraint(equalToConstant: size).isActive = true
        
        labelView.addSubview(timeCountLabel)
        timeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        timeCountLabel.textColor = Colors.coolRed
        timeCountLabel.textAlignment = .center
        timeCountLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 25)
        timeCountLabel.backgroundColor = .clear
        timeCountLabel.centerXAnchor.constraint(equalTo: labelView.centerXAnchor).isActive = true
        timeCountLabel.centerYAnchor.constraint(equalTo: labelView.centerYAnchor).isActive = true
        // timer design finish here.
    }
    
    func setupMiddleView() {
        view.addSubview(middleView)
        middleView.translatesAutoresizingMaskIntoConstraints = false
        middleView.topAnchor.constraint(greaterThanOrEqualTo: topView.bottomAnchor, constant: 10).isActive = true
        middleView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        middleView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -0).isActive = true
        middleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        middleView.layer.borderWidth = 10
        middleView.layer.borderColor = Colors.coolGreen.cgColor
        
        let firstRowView = UIView()
        middleView.addSubview(firstRowView)
        firstRowView.translatesAutoresizingMaskIntoConstraints = false
        firstRowView.topAnchor.constraint(equalTo: middleView.topAnchor).isActive = true
        firstRowView.leftAnchor.constraint(equalTo: middleView.leftAnchor).isActive = true
        firstRowView.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.25).isActive = true
        firstRowView.widthAnchor.constraint(equalTo: middleView.widthAnchor).isActive = true
        
        firstRowView.addSubview(contrary18)
        contrary18.translatesAutoresizingMaskIntoConstraints = false
        contrary18.tag = 100
        contrary18.contentMode = .scaleAspectFit
        contrary18.topAnchor.constraint(equalTo: firstRowView.topAnchor, constant: 10).isActive = true
        contrary18.leftAnchor.constraint(equalTo: firstRowView.leftAnchor).isActive = true
        contrary18.bottomAnchor.constraint(equalTo: firstRowView.bottomAnchor, constant: -0).isActive = true
        contrary18.widthAnchor.constraint(equalTo: firstRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        firstRowView.addSubview(contrary14)
        contrary14.translatesAutoresizingMaskIntoConstraints = false
        contrary14.tag = 101
        contrary14.contentMode = .scaleAspectFit
        contrary14.topAnchor.constraint(equalTo: firstRowView.topAnchor, constant: 10).isActive = true
        contrary14.leftAnchor.constraint(equalTo: contrary18.rightAnchor).isActive = true
        contrary14.bottomAnchor.constraint(equalTo: firstRowView.bottomAnchor, constant: -0).isActive = true
        contrary14.widthAnchor.constraint(equalTo: firstRowView.widthAnchor, multiplier: 0.2).isActive = true

        firstRowView.addSubview(contrary6)
        contrary6.translatesAutoresizingMaskIntoConstraints = false
        contrary6.tag = 102
        contrary6.contentMode = .scaleAspectFit
        contrary6.topAnchor.constraint(equalTo: firstRowView.topAnchor, constant: 10).isActive = true
        contrary6.leftAnchor.constraint(equalTo: contrary14.rightAnchor).isActive = true
        contrary6.bottomAnchor.constraint(equalTo: firstRowView.bottomAnchor, constant: -0).isActive = true
        contrary6.widthAnchor.constraint(equalTo: firstRowView.widthAnchor, multiplier: 0.2).isActive = true

        firstRowView.addSubview(contrary8)
        contrary8.translatesAutoresizingMaskIntoConstraints = false
        contrary8.tag = 103
        contrary8.contentMode = .scaleAspectFit
        contrary8.topAnchor.constraint(equalTo: firstRowView.topAnchor, constant: 10).isActive = true
        contrary8.leftAnchor.constraint(equalTo: contrary6.rightAnchor).isActive = true
        contrary8.bottomAnchor.constraint(equalTo: firstRowView.bottomAnchor, constant: -0).isActive = true
        contrary8.widthAnchor.constraint(equalTo: firstRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        firstRowView.addSubview(contrary5)
        contrary5.translatesAutoresizingMaskIntoConstraints = false
        contrary5.tag = 104
        contrary5.contentMode = .scaleAspectFit
        contrary5.topAnchor.constraint(equalTo: firstRowView.topAnchor, constant: 10).isActive = true
        contrary5.leftAnchor.constraint(equalTo: contrary8.rightAnchor).isActive = true
        contrary5.bottomAnchor.constraint(equalTo: firstRowView.bottomAnchor, constant: -0).isActive = true
        contrary5.widthAnchor.constraint(equalTo: firstRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        let secondRowView = UIView()
        middleView.addSubview(secondRowView)
        secondRowView.translatesAutoresizingMaskIntoConstraints = false
        secondRowView.topAnchor.constraint(equalTo: firstRowView.bottomAnchor).isActive = true
        secondRowView.leftAnchor.constraint(equalTo: middleView.leftAnchor).isActive = true
        secondRowView.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.25).isActive = true
        secondRowView.widthAnchor.constraint(equalTo: middleView.widthAnchor).isActive = true
        
        secondRowView.addSubview(contrary13)
        contrary13.translatesAutoresizingMaskIntoConstraints = false
        contrary13.tag = 105
        contrary13.contentMode = .scaleAspectFit
        contrary13.topAnchor.constraint(equalTo: secondRowView.topAnchor, constant: 10).isActive = true
        contrary13.leftAnchor.constraint(equalTo: secondRowView.leftAnchor).isActive = true
        contrary13.bottomAnchor.constraint(equalTo: secondRowView.bottomAnchor, constant: -0).isActive = true
        contrary13.widthAnchor.constraint(equalTo: secondRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        secondRowView.addSubview(contrary1)
        contrary1.translatesAutoresizingMaskIntoConstraints = false
        contrary1.tag = 106
        contrary1.contentMode = .scaleAspectFit
        contrary1.topAnchor.constraint(equalTo: secondRowView.topAnchor, constant: 10).isActive = true
        contrary1.leftAnchor.constraint(equalTo: contrary13.rightAnchor).isActive = true
        contrary1.bottomAnchor.constraint(equalTo: secondRowView.bottomAnchor, constant: -0).isActive = true
        contrary1.widthAnchor.constraint(equalTo: secondRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        secondRowView.addSubview(contrary3)
        contrary3.translatesAutoresizingMaskIntoConstraints = false
        contrary3.tag = 107
        contrary3.contentMode = .scaleAspectFit
        contrary3.topAnchor.constraint(equalTo: secondRowView.topAnchor, constant: 10).isActive = true
        contrary3.leftAnchor.constraint(equalTo: contrary1.rightAnchor).isActive = true
        contrary3.bottomAnchor.constraint(equalTo: secondRowView.bottomAnchor, constant: -0).isActive = true
        contrary3.widthAnchor.constraint(equalTo: secondRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        secondRowView.addSubview(contrary15)
        contrary15.translatesAutoresizingMaskIntoConstraints = false
        contrary15.tag = 108
        contrary15.contentMode = .scaleAspectFit
        contrary15.topAnchor.constraint(equalTo: secondRowView.topAnchor, constant: 10).isActive = true
        contrary15.leftAnchor.constraint(equalTo: contrary3.rightAnchor).isActive = true
        contrary15.bottomAnchor.constraint(equalTo: secondRowView.bottomAnchor, constant: -0).isActive = true
        contrary15.widthAnchor.constraint(equalTo: secondRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        secondRowView.addSubview(contrary11)
        contrary11.translatesAutoresizingMaskIntoConstraints = false
        contrary11.tag = 109
        contrary11.contentMode = .scaleAspectFit
        contrary11.topAnchor.constraint(equalTo: secondRowView.topAnchor, constant: 10).isActive = true
        contrary11.leftAnchor.constraint(equalTo: contrary15.rightAnchor).isActive = true
        contrary11.bottomAnchor.constraint(equalTo: secondRowView.bottomAnchor, constant: -0).isActive = true
        contrary11.widthAnchor.constraint(equalTo: secondRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        let thirdRowView = UIView()
        middleView.addSubview(thirdRowView)
        thirdRowView.translatesAutoresizingMaskIntoConstraints = false
        thirdRowView.topAnchor.constraint(equalTo: secondRowView.bottomAnchor).isActive = true
        thirdRowView.leftAnchor.constraint(equalTo: middleView.leftAnchor).isActive = true
        thirdRowView.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.25).isActive = true
        thirdRowView.widthAnchor.constraint(equalTo: middleView.widthAnchor).isActive = true
        
        thirdRowView.addSubview(contrary19)
        contrary19.translatesAutoresizingMaskIntoConstraints = false
        contrary19.tag = 110
        contrary19.contentMode = .scaleAspectFit
        contrary19.topAnchor.constraint(equalTo: thirdRowView.topAnchor, constant: 5).isActive = true
        contrary19.leftAnchor.constraint(equalTo: thirdRowView.leftAnchor).isActive = true
        contrary19.bottomAnchor.constraint(equalTo: thirdRowView.bottomAnchor, constant: -5).isActive = true
        contrary19.widthAnchor.constraint(equalTo: thirdRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        thirdRowView.addSubview(contrary17)
        contrary17.translatesAutoresizingMaskIntoConstraints = false
        contrary17.tag = 111
        contrary17.contentMode = .scaleAspectFit
        contrary17.topAnchor.constraint(equalTo: thirdRowView.topAnchor, constant: 5).isActive = true
        contrary17.leftAnchor.constraint(equalTo: contrary19.rightAnchor).isActive = true
        contrary17.bottomAnchor.constraint(equalTo: thirdRowView.bottomAnchor, constant: -5).isActive = true
        contrary17.widthAnchor.constraint(equalTo: thirdRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        thirdRowView.addSubview(contrary16)
        contrary16.translatesAutoresizingMaskIntoConstraints = false
        contrary16.tag = 112
        contrary16.contentMode = .scaleAspectFit
        contrary16.topAnchor.constraint(equalTo: thirdRowView.topAnchor, constant: 5).isActive = true
        contrary16.leftAnchor.constraint(equalTo: contrary17.rightAnchor).isActive = true
        contrary16.bottomAnchor.constraint(equalTo: thirdRowView.bottomAnchor, constant: -5).isActive = true
        contrary16.widthAnchor.constraint(equalTo: thirdRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        thirdRowView.addSubview(contrary4)
        contrary4.translatesAutoresizingMaskIntoConstraints = false
        contrary4.tag = 113
        contrary4.contentMode = .scaleAspectFit
        contrary4.topAnchor.constraint(equalTo: thirdRowView.topAnchor, constant: 5).isActive = true
        contrary4.leftAnchor.constraint(equalTo: contrary16.rightAnchor).isActive = true
        contrary4.bottomAnchor.constraint(equalTo: thirdRowView.bottomAnchor, constant: -5).isActive = true
        contrary4.widthAnchor.constraint(equalTo: thirdRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        thirdRowView.addSubview(contrary7)
        contrary7.translatesAutoresizingMaskIntoConstraints = false
        contrary7.tag = 114
        contrary7.contentMode = .scaleAspectFit
        contrary7.topAnchor.constraint(equalTo: thirdRowView.topAnchor, constant: 5).isActive = true
        contrary7.leftAnchor.constraint(equalTo: contrary4.rightAnchor).isActive = true
        contrary7.bottomAnchor.constraint(equalTo: thirdRowView.bottomAnchor, constant: -5).isActive = true
        contrary7.widthAnchor.constraint(equalTo: thirdRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        let fourthRowView = UIView()
        middleView.addSubview(fourthRowView)
        fourthRowView.translatesAutoresizingMaskIntoConstraints = false
        fourthRowView.topAnchor.constraint(equalTo: thirdRowView.bottomAnchor).isActive = true
        fourthRowView.leftAnchor.constraint(equalTo: middleView.leftAnchor).isActive = true
        fourthRowView.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.25).isActive = true
        fourthRowView.widthAnchor.constraint(equalTo: middleView.widthAnchor).isActive = true
        
        fourthRowView.addSubview(contrary20)
        contrary20.translatesAutoresizingMaskIntoConstraints = false
        contrary20.tag = 115
        contrary20.contentMode = .scaleAspectFit
        contrary20.topAnchor.constraint(equalTo: fourthRowView.topAnchor).isActive = true
        contrary20.leftAnchor.constraint(equalTo: fourthRowView.leftAnchor).isActive = true
        contrary20.bottomAnchor.constraint(equalTo: fourthRowView.bottomAnchor, constant: -10).isActive = true
        contrary20.widthAnchor.constraint(equalTo: fourthRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        fourthRowView.addSubview(contrary9)
        contrary9.translatesAutoresizingMaskIntoConstraints = false
        contrary9.tag = 116
        contrary9.contentMode = .scaleAspectFit
        contrary9.topAnchor.constraint(equalTo: fourthRowView.topAnchor).isActive = true
        contrary9.leftAnchor.constraint(equalTo: contrary20.rightAnchor).isActive = true
        contrary9.bottomAnchor.constraint(equalTo: fourthRowView.bottomAnchor, constant: -10).isActive = true
        contrary9.widthAnchor.constraint(equalTo: fourthRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        fourthRowView.addSubview(contrary10)
        contrary10.translatesAutoresizingMaskIntoConstraints = false
        contrary10.tag = 117
        contrary10.contentMode = .scaleAspectFit
        contrary10.topAnchor.constraint(equalTo: fourthRowView.topAnchor).isActive = true
        contrary10.leftAnchor.constraint(equalTo: contrary9.rightAnchor).isActive = true
        contrary10.bottomAnchor.constraint(equalTo: fourthRowView.bottomAnchor, constant: -10).isActive = true
        contrary10.widthAnchor.constraint(equalTo: fourthRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        fourthRowView.addSubview(contrary12)
        contrary12.translatesAutoresizingMaskIntoConstraints = false
        contrary12.tag = 118
        contrary12.contentMode = .scaleAspectFit
        contrary12.topAnchor.constraint(equalTo: fourthRowView.topAnchor).isActive = true
        contrary12.leftAnchor.constraint(equalTo: contrary10.rightAnchor).isActive = true
        contrary12.bottomAnchor.constraint(equalTo: fourthRowView.bottomAnchor, constant: -10).isActive = true
        contrary12.widthAnchor.constraint(equalTo: fourthRowView.widthAnchor, multiplier: 0.2).isActive = true
        
        fourthRowView.addSubview(contrary2)
        contrary2.translatesAutoresizingMaskIntoConstraints = false
        contrary2.tag = 119
        contrary2.contentMode = .scaleAspectFit
        contrary2.topAnchor.constraint(equalTo: fourthRowView.topAnchor).isActive = true
        contrary2.leftAnchor.constraint(equalTo: contrary12.rightAnchor).isActive = true
        contrary2.bottomAnchor.constraint(equalTo: fourthRowView.bottomAnchor, constant: -10).isActive = true
        contrary2.widthAnchor.constraint(equalTo: fourthRowView.widthAnchor, multiplier: 0.2).isActive = true
        
    }

    func setupBottomView() {
        view.addSubview(birdView)
        birdView.translatesAutoresizingMaskIntoConstraints = false
        birdView.topAnchor.constraint(greaterThanOrEqualTo: middleView.bottomAnchor, constant: 10).isActive = true
        birdView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        birdView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        birdView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2 ).isActive = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view?.isKind(of: MyImageView.self) ?? false {
            let currentTouchView = touch?.view as! MyImageView
            currentTouchView.turn2Left()
            self.clickPlayer.play()
            if (self.tempImageView == nil)
            {
                self.tempImageView = currentTouchView
            }
            else
            {
                if(currentTouchView.myTag == self.tempImageView.myTag)
                {
                    self.doublePlayer.play()
                    self.tempImageView = nil
                    self.doubleCount+=1
                    if(self.doubleCount == 10)
                    {
                        self.gameWin()
                    }
                }
                else
                {
                    self.tempImageView.turn2Right()
                    self.tempImageView = currentTouchView
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIAlertController {
    
    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor, borderWidth: CGFloat, borderColor: CGColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
            contentView.layer.borderWidth = borderWidth
            contentView.layer.borderColor = borderColor
        }
    }
    
    //Set title font and title color
    func setTitleText(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)//1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                range: NSMakeRange(0, title.utf8.count))
        }
        
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }
    
    //Set message font and message color
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        
        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }
    
    //Set tint color of UIAlertController
    func setTint(color: UIColor) {
        self.view.tintColor = color
    }

}

extension UIAlertAction {
    //Set title font and title color
    func setTitleText(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)//1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                range: NSMakeRange(0, title.utf8.count))
        }
        
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "titleTextColor")//4
    }
}

