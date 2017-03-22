//
//  ViewController.swift
//  QP_AVCapture
//
//  Created by JackieQu on 2017/3/22.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    fileprivate lazy var videoQueue = DispatchQueue.global()
    
    fileprivate lazy var session : AVCaptureSession = AVCaptureSession()
    fileprivate lazy var previewLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK:- 视频的开始采集、停止采集
extension ViewController {
    @IBAction func startCapture() {
        // 1.创建捕捉会话
        let session = AVCaptureSession()
        self.session = session
        
        // 2.设置输入源(摄像头)
        // 2.1.获取摄像头设备
        guard let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice] else {
            
            print("摄像头不可用")
            return
        }
        
        /*
        var device : AVCaptureDevice!
        for d in devices {
            if d.position == .front {
                device = d
                break
            }
        }
         */
        /*
        let device = devices.filter { (device : AVCaptureDevice) -> Bool in
            return device.position == .front
        }.first
         */
        
        guard let device = devices.filter({ $0.position == .front }).first else { return }
        
        // 2.2.通过 device 创建 AVCaptureInput 对象
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        // 2.3.将 input 添加到会话中
        session.addInput(videoInput)
        
        // 3.设置输出源
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        
        session.addOutput(videoOutput)
        
        // 4.设置预览图层
//        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
//        previewLayer?.frame = view.bounds
//        view.layer.addSublayer(previewLayer!)
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        
        // 5.开始采集
        session.startRunning()
    }
    
    @IBAction func stopCapture() {
        session.stopRunning()
        previewLayer.removeFromSuperlayer()
    }
}

extension ViewController : AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        print("已经采集画面")
    }
}


