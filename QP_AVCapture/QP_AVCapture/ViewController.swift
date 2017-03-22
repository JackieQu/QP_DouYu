//
//  ViewController.swift
//  QP_AVCapture
//
//  Created by JackieQu on 2017/3/22.
//  Copyright © 2017年 JackieQu. All rights reserved.
//
//  视频、音频的采集、写入文件练习

import UIKit
import AVFoundation

class ViewController: UIViewController {

    fileprivate lazy var videoQueue = DispatchQueue.global()
    fileprivate lazy var audioQueue = DispatchQueue.global()
    
    fileprivate lazy var session : AVCaptureSession = AVCaptureSession()
    fileprivate lazy var previewLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
//    fileprivate var connection : AVCaptureConnection?
    fileprivate var videoOutput : AVCaptureVideoDataOutput?
    fileprivate var videoInput : AVCaptureDeviceInput?
    fileprivate var movieOutput : AVCaptureMovieFileOutput?
}

// MARK:- 视频的开始采集、停止采集
extension ViewController {
    @IBAction func startCapture() {
        // 1.设置视频输入、输出
        setupVideo()
        
        // 2.设置音频输入、输出
        setupAudio()
        
        // 3.添加写入文件的 output
        let movieOutput = AVCaptureMovieFileOutput()
        session.addOutput(movieOutput)
        self.movieOutput = movieOutput
        // 设置写入稳定性
        let connection = movieOutput.connection(withMediaType: AVMediaTypeVideo)
        connection?.preferredVideoStabilizationMode = .auto

        // 4.设置预览图层
//        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
//        previewLayer?.frame = view.bounds
//        view.layer.addSublayer(previewLayer!)
        previewLayer.frame = view.bounds
//        view.layer.addSublayer(previewLayer)
        view.layer.insertSublayer(previewLayer, at: 0)
        
        // 5.开始采集
        session.startRunning()
        
        // 6.将采集到的画面写入到文件中
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/test.mp4"
        let url = URL(fileURLWithPath: path)
        movieOutput.startRecording(toOutputFileURL: url, recordingDelegate: self)
    }
    
    @IBAction func stopCapture() {
        // 停止写入
        movieOutput?.stopRecording()
        // 停止采集
        session.stopRunning()
        previewLayer.removeFromSuperlayer()
        print("停止采集")
    }
    
    @IBAction func switchScene() {
        // 1.获取当前镜头
        guard var position = videoInput?.device.position else { return }
        
        // 2.获取将要显示镜头
        position = position == .front ? .back : .front
        
        // 3.根据将要显示镜头创建 device
        let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as! [AVCaptureDevice]
        guard let device = devices.filter({ $0.position == position }).first else { return }
        
        // 4.根据 device 创建 input
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        // 5.在 session 中切换 input
        session.beginConfiguration()
        session.removeInput(self.videoInput!)
        session.addInput(videoInput)
        session.commitConfiguration()
        
        print("切换镜头")
        self.videoInput = videoInput
    }
}

extension ViewController {
    fileprivate func setupVideo() {
        // 1.创建捕捉会话
        //        let session = AVCaptureSession()
        //        self.session = session
        
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
        self.videoInput = videoInput
        
        // 2.3.将 input 添加到会话中
        session.addInput(videoInput)
        
        // 3.设置输出源
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        
        session.addOutput(videoOutput)
        
        // 4.获取 video 对应的 connection
//        connection = videoOutput.connection(withMediaType: AVMediaTypeVideo)
        self.videoOutput = videoOutput
    }
    
    fileprivate func setupAudio() {
        // 1.设置输入源(麦克风)
        // 1.1.获取设备麦克风
        guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio) else { return }
        
        // 1.2.根据 device 创建 AVCaptureInput
        guard let audioInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        // 1.3.将 input 添加到会话中
        session.addInput(audioInput)
        
        // 2.设置输出源
        let audioOutput = AVCaptureAudioDataOutput()
        audioOutput.setSampleBufferDelegate(self, queue: audioQueue)
        session.addOutput(audioOutput)
    }
}

// MARK:- 获取数据
extension ViewController : AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        if connection == videoOutput?.connection(withMediaType: AVMediaTypeVideo) {
            print("已经采集视频—-video")
        } else {
            print("已经采集音频--audio")
        }
    }
}

// MARK:- 
extension ViewController : AVCaptureFileOutputRecordingDelegate {
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        print("开始写入文件")
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        print("结束写入文件")
    }
}


