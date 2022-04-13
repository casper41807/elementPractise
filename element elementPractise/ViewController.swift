//
//  ViewController.swift
//  element elementPractise
//
//  Created by 陳秉軒 on 2022/3/22.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {

   
    @IBOutlet weak var songImageView: UIImageView!
    
    @IBOutlet weak var songPage: UIPageControl!
    
    @IBOutlet weak var songSegmented: UISegmentedControl!
    
    @IBOutlet weak var songLabel: UILabel!
    
    @IBOutlet weak var nextSongButton: UIButton!
    
    @IBOutlet weak var previousSongButton: UIButton!
    
    @IBOutlet weak var sliderOutlet: UISlider!
    
    @IBOutlet weak var stopbutton: UIButton!
    
    @IBOutlet weak var playTimeSlider: UISlider!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var songTimeLabel: UILabel!
    
    @IBOutlet weak var repeatOutlet: UIButton!
    
    @IBOutlet weak var randomOutlet: UIButton!
    
    
    
    
    let player = AVPlayer()
    var fileUrl = Bundle.main.url(forResource: "", withExtension: "mp3")
    var playerItem:AVPlayerItem?
    
    let imageArray = ["image1","image2","image3","image4","image5"]
    let songNameArray = ["帶我去找夜生活","愛人錯過","披星戴月的想你","好不容易","在這座城市遺失了你"]
    let pageNumber = ["1/5","2/5","3/5","4/5","5/5"]
    var num:Int = 0
    var randomIndex = 0
    var repeatIndex = 0
    var totalTime:Float64?
    var songCurrentShape = CAShapeLayer()
    
    
    func sync(){
        songImageView.image = UIImage(named: imageArray[num])
        songLabel.text = pageNumber[num]
        songPage.currentPage = num
        songSegmented.selectedSegmentIndex = num
    }
    
    func imageSitting(){
        songImageView.layer.borderWidth = 5
        songImageView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [CGColor(red: 67/255, green: 47/255, blue: 87/255, alpha: 1),CGColor(red: 44/255, green: 50/255, blue: 66/255, alpha: 1)]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func musicPlayer(){
        if num == 0{
            fileUrl = Bundle.main.url(forResource: "\(num)", withExtension: "mp3")
        }else if num == 1{
            fileUrl = Bundle.main.url(forResource: "\(num)", withExtension: "mp3")
        }else if num == 2{
            fileUrl = Bundle.main.url(forResource: "\(num)", withExtension: "mp3")
        }else if num == 3{
            fileUrl = Bundle.main.url(forResource: "\(num)", withExtension: "mp3")
        }else{
            fileUrl = Bundle.main.url(forResource: "\(num)", withExtension: "mp3")
        }
        playerItem = AVPlayerItem(url: fileUrl!)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        stopbutton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        //setupNowPlaying()
        setupNowPlaying()
        
        resumeAnimation()
        
       
        
       
        
    }
    func segmentedText(){
        songSegmented.setTitle(songNameArray[0], forSegmentAt: 0)
        songSegmented.setTitle(songNameArray[1], forSegmentAt: 1)
        songSegmented.setTitle(songNameArray[2], forSegmentAt: 2)
        songSegmented.setTitle(songNameArray[3], forSegmentAt: 3)
        songSegmented.setTitle(songNameArray[4], forSegmentAt: 4)
        let font = UIFont.systemFont(ofSize:8)
        songSegmented.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sync()
        imageSitting()
        musicPlayer()
        segmentedText()
        updateMusciSlider()
        nowPlayTime()
        musicEnd()
       // setupRemoteTransportControls()
        setupNowPlaying()
        setupRemoteCommandCenter()
        
        rotate()
        
        
        
        
        
    }
    @IBAction func pageControl(_ sender: UIPageControl) {
        
        if songPage.currentPage == 0{
            num = 0
        }else if songPage.currentPage == 1{
            num = 1
        }else if songPage.currentPage == 2{
            num = 2
        }else if songPage.currentPage == 3{
            num = 3
        }else{
            num = 4
        }
        sync()
        musicPlayer()
        updateMusciSlider()
    }
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        if songSegmented.selectedSegmentIndex == 0{
            num = 0
        }else if songSegmented.selectedSegmentIndex == 1{
            num = 1
        }else if songSegmented.selectedSegmentIndex == 2{
            num = 2
        }else if songSegmented.selectedSegmentIndex == 3{
            num = 3
        }else{
            num = 4
        }
        sync()
        musicPlayer()
        updateMusciSlider()
    }
    @IBAction func nextButton(_ sender: UIButton) {
        if randomIndex == 1{
            num = Int.random(in: 0...imageArray.count - 1)
            sync()
            musicPlayer()
            updateMusciSlider()
        }else{
            num += 1
            if num > 4{
                num = 0
            }
            sync()
            musicPlayer()
            updateMusciSlider()
        }
    }
    @IBAction func previousButton(_ sender: UIButton) {
        if randomIndex == 1{
            num = Int.random(in: 0...imageArray.count - 1)
            sync()
            musicPlayer()
            updateMusciSlider()
        }else{
            num -= 1
            if num < 0{
                num = 4
            }
            sync()
            musicPlayer()
            updateMusciSlider()
        }
       
    }
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        num += 1
        if num > 4{
            num = 4
        }
        sync()
        musicPlayer()
        updateMusciSlider()
        
    }
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        num -= 1
        if num < 0{
            num = 0
        }
        sync()
        musicPlayer()
        updateMusciSlider()
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        if player.rate == 0{
            stopbutton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            player.play()
            
            resumeAnimation()
        }else{
            stopbutton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player.pause()
            pauseAnimation()
            
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        player.volume = sliderOutlet.value
    }
   
    
    @IBAction func repeatButton(_ sender: UIButton) {
        repeatIndex += 1
        if repeatIndex == 1{
            repeatOutlet.setImage(UIImage(systemName: "repeat.1"), for: .normal)
        }else{
            repeatIndex = 0
            repeatOutlet.setImage(UIImage(systemName: "repeat"), for: .normal)
        }
    }
    @IBAction func randomButton(_ sender: UIButton) {
        randomIndex += 1
        if randomIndex == 1{
            randomOutlet.setImage(UIImage(systemName: "shuffle.circle.fill"), for: .normal)
        }else{
            randomIndex = 0
            randomOutlet.setImage(UIImage(systemName: "shuffle.circle"), for: .normal)
        }
    }
    

    
    
    @IBAction func playTimeAction(_ sender: UISlider) {
        let changeTime = Int64(sender.value)
        let time = CMTime(value: changeTime, timescale: 1
        )
        player.seek(to: time)
    }
    //    更新歌曲時確認歌的時間讓Slider也更新
    func updateMusciSlider(){
        let duration = playerItem!.asset.duration
        let seconds = CMTimeGetSeconds(duration)
        totalTime = seconds
        totalTimeLabel.text = timeShow(time: seconds)
        
        playTimeSlider.minimumValue = 0
        //最大值就是這首歌的總秒數
        playTimeSlider.maximumValue = Float(seconds)
        //slider會不會持續動作
        playTimeSlider.isContinuous = true
    }
    func timeShow(time: Double) -> String {
        //轉換成秒數
        let time = Int(time).quotientAndRemainder(dividingBy: 60)
        //顯示分鐘與秒數
        let timeString = "\(String(time.quotient)) : \(String(format:"%02d", time.remainder))"
        //回傳到顯示
        return timeString
    }
    func nowPlayTime(){
        //播放的計數器從1開始每一秒都在播放
        // let timeScale = CMTimeScale(NSEC_PER_SEC)
        // let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main, using: { (CMTime) in
            //如果音樂要播放
            if self.player.currentItem?.status == .readyToPlay{
                //就會得到player播放的時間
                let currenTime = CMTimeGetSeconds(self.player.currentTime())
                //Slider移動就會等於currenTime的時間
                self.playTimeSlider.value = Float(currenTime)
                //顯示播放了幾秒
                self.songTimeLabel.text = self.timeShow(time: currenTime)
                self.songProgressBar(time:currenTime)
            }
        })
    }
    func musicEnd(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { [self] (_) in
                if repeatIndex == 1 {
                    let musicEndTime: CMTime = CMTimeMake(value: 0, timescale: 1)
                    player.seek(to: musicEndTime)
                    player.play()
                }else{
                    if randomIndex == 1{
                        num = Int.random(in: 0...imageArray.count - 1)
                        sync()
                        musicPlayer()
                        updateMusciSlider()
                    }else{
                        num += 1
                        if num > 4{
                            num = 0
                        }
                        sync()
                        musicPlayer()
                        updateMusciSlider()
                    }
                }
        }
    }
    
    //唱片動畫
    func rotate(){
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = CGFloat.pi*2
        animation.duration = 10
        animation.repeatCount = .infinity
        songImageView.layer.add(animation, forKey: nil)
    }
    func pauseAnimation() {
        let pausedTime = songImageView.layer.convertTime(CACurrentMediaTime(), from: nil)
        songImageView.layer.speed = 0
        songImageView.layer.timeOffset = pausedTime
    }

    func resumeAnimation() {
        let pausedTime = songImageView.layer.timeOffset
        songImageView.layer.speed = 1
        songImageView.layer.timeOffset = 0
        songImageView.layer.beginTime = 0
        let timeSincePause = songImageView.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        songImageView.layer.beginTime = timeSincePause
    }
//
//    func songProgressBar(time: CGFloat) -> UIView {
//            let startAngle = CGFloat.pi / 2 * 3
//
//            //當前進度除以音樂長度取得角度
//            //let angle:CGFloat = 360 * time / totalTime!
//            //let endAngle = startAngle + angle
//
//            let songCurrenPath = UIBezierPath()
//            songCurrenPath.addArc(withCenter: CGPoint(x: 200, y: 200), radius: 170, startAngle: startAngle, endAngle: 270, clockwise: true)
//            songCurrentShape.path = songCurrenPath.cgPath
//            songCurrentShape.strokeColor = UIColor.orange.cgColor
//            songCurrentShape.lineWidth = 4
//            songCurrentShape.lineCap = .round
//            songCurrentShape.fillColor = UIColor.clear.cgColor
//            view.layer.addSublayer(songCurrentShape)
//
//            let animation = CABasicAnimation(keyPath: "strokeEnd")
//                animation.fromValue = 0
//                animation.toValue = totalTime
//                animation.duration = time
//                animation.repeatCount = .greatestFiniteMagnitude
//                songCurrentShape.add(animation, forKey: nil)
//
//            return view
//        }
    
    func songProgressBar(time: CGFloat) -> UIView {
            let startAngle = CGFloat.pi / 2 * 3
            let aDegree = CGFloat.pi / 180
            //當前進度除以音樂長度取得角度
            let angle:CGFloat = 360 * time / totalTime!
            let endAngle = startAngle + angle*aDegree
            
        
            let songCurrenPath = UIBezierPath()
        songCurrenPath.addArc(withCenter: CGPoint(x: view.frame.width/2, y: 228), radius: 168, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            songCurrentShape.path = songCurrenPath.cgPath
            songCurrentShape.strokeColor = UIColor.orange.cgColor
            songCurrentShape.lineWidth = 5
            songCurrentShape.lineCap = .round
            songCurrentShape.fillColor = UIColor.clear.cgColor
            view.layer.addSublayer(songCurrentShape)
            print(endAngle)
            print(startAngle)
            
            return view
        }
    
//    func setupRemoteTransportControls() {
//        // Get the shared MPRemoteCommandCenter
//        let commandCenter = MPRemoteCommandCenter.shared()
//
//        // Add handler for Play Command
//        commandCenter.playCommand.addTarget { [unowned self] event in
//            if self.player.rate == 0.0 {
//                self.player.play()
//                return .success
//            }
//            return .commandFailed
//        }
//
//        // Add handler for Pause Command
//        commandCenter.pauseCommand.addTarget { [unowned self] event in
//            if self.player.rate == 1.0 {
//                self.player.pause()
//                return .success
//            }
//            return .commandFailed
//        }
//    }
//      //設定背景播放的歌曲資訊
//    func setupNowPlaying() {
//        // Define Now Playing Info
//
//
//
//        var nowPlayingInfo = [String : Any]()
//        nowPlayingInfo[MPMediaItemPropertyTitle] = "\(num)"
//        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = songNameArray[num]
//
//        if let image = UIImage(named:imageArray[num]) {
//            nowPlayingInfo[MPMediaItemPropertyArtwork] =
//                MPMediaItemArtwork(boundsSize: image.size) { size in
//                    return image
//            }
//        }
//        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.currentTime().seconds
//        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player.currentItem?.asset.duration.seconds
//        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate
//
//        // Set the metadata
//        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
//    }
    
    func setupNowPlaying(){
            var nowPlayingInfo = [String : Any]() //宣告正在播放的資訊dictionary

            nowPlayingInfo[MPMediaItemPropertyTitle] = songNameArray[num] //設定正在播放的歌名
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = playerItem?.currentTime().seconds //設定歌曲目前的時間
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = playerItem?.asset.duration.seconds //設定歌曲總時間
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate //設定歌曲速率
            nowPlayingInfo[MPMediaItemPropertyArtist] = "告五人" //設定歌手

            if let image = UIImage(named: imageArray[num]) {
                nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: {size in
                    return image
                })
            } //設定歌曲圖片

            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo //初始歌曲資訊
            MPNowPlayingInfoCenter.default().playbackState = .playing
        }
    func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared();
        commandCenter.playCommand.isEnabled = true
        //背景slider調整時間
        commandCenter.changePlaybackPositionCommand.addTarget { [unowned self] event in
            if let remoteEvent = event as? MPChangePlaybackPositionCommandEvent {
                let time = CMTime(seconds: remoteEvent.positionTime, preferredTimescale: 1)
                self.player.seek(to: time)
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.playCommand.addTarget {event in
                self.stopButton(self.stopbutton)
                MPNowPlayingInfoCenter.default().playbackState = .playing
                return .success
        }

        commandCenter.pauseCommand.addTarget{event in
                self.stopButton(self.stopbutton)
            MPNowPlayingInfoCenter.default().playbackState = .paused
                return .success
        }

        commandCenter.nextTrackCommand.addTarget{event in
            self.nextButton(self.nextSongButton)
            MPNowPlayingInfoCenter.default().playbackState = .playing
            return .success
        }

        commandCenter.previousTrackCommand.addTarget{event in
            self.previousButton(self.previousSongButton)
            MPNowPlayingInfoCenter.default().playbackState = .playing
            return .success
        }
        
        

        commandCenter.togglePlayPauseCommand.isEnabled = true
        commandCenter.changePlaybackRateCommand.isEnabled = true
    }
}

