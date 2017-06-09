//
//  VideoDetailController.swift
//  AmiCoolDemo
//
//  Created by AlbertShepherd on 2017/6/8.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class VideoDetailController: UIViewController {
    var videoModle:VideoReturnJson? = nil  //视频模型
    var avPlayer:AVPlayer!
    var playerLayer:AVPlayerLayer!
    var controlView:UIView!  //控制条视图
    var playBt:UIButton!
    var slider:UISlider!
    var timeLab:UILabel!
    var hideState:Bool = false
    var sliding:Bool = false
    var obser:Any! //监听器
    
    @IBOutlet weak var VideoWebView: UIWebView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var videoTitle: UILabel! //视频标题
    @IBOutlet weak var author: UILabel!     //作者
    @IBOutlet weak var course: UILabel!             // 课程
    @IBOutlet weak var timeUpload: UILabel!
    @IBOutlet weak var desc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置左上角返回按钮
        //self.navigationItem.leftBarButtonItem =
        
        let bt = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        bt.setImage(UIImage(named:"images/back.png"), for: .normal)
        bt.addTarget(self, action: #selector(VideoDetailController.back), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: bt)
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        // 播放器界面设置
        avPlayerConfiguration()

        // Do any additional setup after loading the view.
        
        // 
//        
//        // 1.设置访问资源 - 百度搜索
//        let url = URL(string: videoModle!.videopath!)!
//        
//        // 2.建立网络请求
//        let request = URLRequest(url: url)
//        
//        // 3.加载网络请求
//        VideoWebView.loadRequest(request)
        //self.desc.numberOfLines = 0
        // self.desc.sizeToFit()
        if self.videoModle != nil{
            self.videoTitle.text = self.videoModle?.name
            self.author.text = self.videoModle?.author
            self.desc.text = self.videoModle?.decs
            self.timeUpload.text = self.videoModle?.update_time
            
            self.course.text = self.videoModle?.kcmc
        
        }
        
        
        
    }
    //MARK:播放界面配置

    func avPlayerConfiguration(){
        //配置playerView,播放图层，添加单击手势
        playerView.layer.masksToBounds = true
        playerView.backgroundColor = UIColor.black
        playerView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                               action: #selector(VideoDetailController.showControl)))
        //播放器，保持视频比例填充到图层
        avPlayer = AVPlayer(url: URL(string: videoModle!.videopath!)!)
        playerLayer = AVPlayerLayer(player: avPlayer)
        playerLayer.frame = CGRect(origin: CGPoint.zero, size: playerView.frame.size)
        playerLayer.videoGravity = AVVideoScalingModeResizeAspect
        playerView.layer.addSublayer(playerLayer)
        
        //控制条视图， 带有阴影效果，添加到播放视图上
        let height = self.view.bounds.height
        let width = playerView.bounds.width
        
        controlView = UIView(frame: CGRect(x: 0,
                                           y: height-35,
                                           width: width,
                                           height: 35))
        controlView.backgroundColor = UIColor.clear
        let blurEffectView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 35))
        blurEffectView.backgroundColor = UIColor.darkGray
        blurEffectView.layer.opacity = 0.5
        controlView.addSubview(blurEffectView)
        playerView.addSubview(controlView)
        
        //播放按钮，添加至控制条上
        playBt = UIButton(frame: CGRect(x: 10, y: 5, width: 25, height: 25))
        playBt.setImage(UIImage(named:"images/play.png"), for: .normal)
        playBt.tintColor = UIColor.white
        playBt.addTarget(self, action: #selector(VideoDetailController.play), for: .touchUpInside)
        controlView.addSubview(playBt)
        //全屏按钮
        let fullBt = UIButton(frame: CGRect(x: 10, y: 5, width: 25, height: 25))
        fullBt.center = CGPoint(x: width-35+25/2, y: playBt.center.y)
        fullBt.setImage(UIImage(named:"images/full.png"), for: .normal)
        fullBt.tintColor = UIColor.white
        fullBt.addTarget(self, action: #selector(VideoDetailController.fullScreen), for: .touchUpInside)
        controlView.addSubview(fullBt)
        //滑动条，添加至控制条里
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: width-150, height: 5))
        slider.center = CGPoint(x: 40+width/2-70, y: playBt.center.y)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        let thumbImg = UIImage(named:"images/slider.png")?.scaleImageToSize(CGSize(width: 10, height: 10))
        slider.setThumbImage(thumbImg, for: .normal)
        slider.addTarget(self,
                         action: #selector(VideoDetailController.slidertouchDown),
                         for: .touchDown)
        slider.addTarget(self,
                         action: #selector(VideoDetailController.slidertouchOut),
                         for: .touchUpInside)
        controlView.addSubview(slider)
        
        
        //时间标签，添加至控制条
        timeLab = UILabel(frame: CGRect(x: 0, y: 0, width: 65, height: 20))
        timeLab.center = CGPoint(x: width-62, y: playBt.center.y)
        timeLab.text = "00:00/00:00"
        timeLab.font = UIFont.systemFont(ofSize: 10)
        timeLab.backgroundColor = UIColor.clear
        timeLab.textColor = UIColor.white
        controlView.addSubview(timeLab)
        
        //监听
        addObser()
    
        self.perform(#selector(VideoDetailController.hideControl),
                     with: self,
                     afterDelay: 3)
        
    }
    
    func addObser(){
        obser = avPlayer.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 1), queue: .main) { [weak self](time) in
            var totalSec:String!
            var currentSec:String!
            let currentTime = CMTimeGetSeconds(time)
            let totalTime = CMTimeGetSeconds((self?.avPlayer.currentItem?.duration)!) //视频的总时长
            if self!.sliding{
                self!.slider.setValue(Float(currentTime/totalTime), animated: true)
            }
            if currentTime.isNaN || totalTime.isNaN{
                totalSec = "00:00"
                currentSec = "00:00"
            }else{
                totalSec = String(format: "%02d:%02d", Int(totalTime/60),Int(totalTime.truncatingRemainder(dividingBy: 60)))
                currentSec = String(format: "%02d:%02d", Int(currentTime/60),Int(currentTime.truncatingRemainder(dividingBy: 60)))
            }
            self?.timeLab.text = "\(currentSec!)/\(totalSec!)"
        }    }
    
    
    //MARK: 滑动条
    func slidertouchDown(){
        sliding = !sliding
        
    }
    
    func slidertouchOut(){
        avPlayer.seek(to: CMTime(seconds: Double(self.slider.value*Float(CMTimeGetSeconds((self.avPlayer.currentItem?.duration)!))), preferredTimescale: 1)){[weak self](_) in
                self!.sliding = !(self!.sliding)
        }
    }
    
    
    //MARK:播放视频
    func play(){
        if avPlayer.rate == 0{
            avPlayer.play()
            playBt.setImage(UIImage(named:"images/pause.png"), for: .normal)
        }
        else if avPlayer.rate == 1{
            avPlayer.pause()
             playBt.setImage(UIImage(named:"images/play.png"), for: .normal)
        }
        
    }
    //全屏
    func fullScreen(){
        let w = UIScreen.main.bounds.width  //获取屏幕的高度 宽度值
        let h = UIScreen.main.bounds.height
        let pw = playerView.bounds.width     //player 的宽度高度
        let ph = playerView.bounds.height           //为了保持等比例缩放
        if !hideState{
            view.bringSubview(toFront: playerView)
            UIView.animate(withDuration: 0.3, animations: {
                self.playerView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/180)*CGFloat(90)).concatenating(CGAffineTransform(scaleX: w/ph, y: h/pw)).concatenating(CGAffineTransform(translationX: 0, y: 233.5-64))
            })
            hideState = !hideState
            self.setNeedsStatusBarAppearanceUpdate()
        }
        else{
            UIView.animate(withDuration: 0.3, animations: {
                self.playerView.transform = .identity
            })
            hideState = !hideState
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
    }
    
    //MARK: 显示控制条视图
    func showControl(){
        if controlView.frame.origin.y == playerView.bounds.height{
            UIView.animate(withDuration: 0.2, animations: {
                self.controlView.frame.origin.y = self.playerView.bounds.height -
                    self.controlView.bounds.height
            }, completion: { (_) in
                self.perform(#selector(VideoDetailController.hideControl),
                             with: self,
                             afterDelay: 3)
            })
        }
    }
    
    func hideControl(){
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.duration = 0.2
        self.controlView.layer.frame.origin.y = self.playerView.bounds.height
        self.controlView.layer.add(animation, forKey: nil)
    }
    
    
    //MARK:返回按钮
    func back(){
        avPlayer.removeTimeObserver(obser)
        avPlayer.currentItem?.asset.cancelLoading()
        avPlayer.currentItem?.cancelPendingSeeks()
        avPlayer.replaceCurrentItem(with: nil)
        avPlayer = nil
        playerLayer.removeFromSuperlayer()
        playerLayer = nil
        
        //当前界面出栈
        self.navigationController?.popViewController(animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
