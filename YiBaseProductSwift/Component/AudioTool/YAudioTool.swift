//
//  YAudioTool.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/10/13.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation
import AVFoundation
import RxSwift
import RxRelay
import PromiseKit

/// 录音工具类
public class YAudioTool: NSObject {
    public enum AudioStatus {
        //初始化
        case initial
        //准备
        case prepare
        //录音进行中
        case recording
        //取消录音
        case cancel
        //录音失败
        case failed(reason: String?)
        //录音完毕
        case complete
        //转换音频格式
        case convert
        //转换格式完成，输出mp3路径
        case success
    }
    
    public let recordStatusRelay = BehaviorRelay<AudioStatus>(value: .initial)
    public let mp3InfoRelay = BehaviorRelay<(URL?, Float?)>(value: (nil, nil))
    public let volumeRelay  = BehaviorRelay<Float>(value: 0)
    
    private var _recorder: AVAudioRecorder?
    private let _rate: Int32 = 8000
    private var _cafPath: URL?
    private var _mp3Path: URL?
    private var _player: AVAudioPlayer?
    private var _timer: YGCDTimer?
    
    private let _maxVolume: Float = 160
    private let _cardinalNumber: Float = 120
    
    deinit {
        debugPrint("Audiotool被销毁")
    }
}

//MARK: public func
extension YAudioTool {
    
    public func prepareRecord() -> Promise<YAudioTool> {
        recordStatusRelay.accept(.prepare)
        return Promise { seal in
            _setUpAudioSession()
                .then(_updateFilePath)
                .then(_setUpRecord)
                .done({ [weak self] _ in
                    guard let self = self else { return }
                    self._recorder?.prepareToRecord()
                    seal.fulfill(self)
                })
                .catch { [weak self] error in
                    self?._clearnFilePath()
                    seal.reject(error)
                }
        }
    }
    
    public func start() {
        _player?.pause()
        recordStatusRelay.accept(.recording)
        self._recorder?.record()
        _setUpTimer()
    }
    
    public func cancel() {
        recordStatusRelay.accept(.cancel)
        _recorder?.stop()
        _timer?.suspend()
    }
    
    public func complete() {
        recordStatusRelay.accept(.complete)
        _recorder?.stop()
        _timer?.suspend()
    }
    
    public func destroy() {
        _timer?.destroy()
        _recorder?.stop()
        _player?.stop()
    }
    
    /// attesion: can only play local resources
    public func play(url: URL, useSpeaker: Bool = false) {
        _player = try? AVAudioPlayer(contentsOf: url)
        if useSpeaker {
            try? AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
        } else {
            try? AVAudioSession.sharedInstance().overrideOutputAudioPort(.none)
        }
        _player?.play()
    }
}

//MARK: private func
extension YAudioTool {
    private func _setUpAudioSession() -> Promise<Void> {
        let audioSession = AVAudioSession.sharedInstance()
        return Promise { seal in
            do {
                try audioSession.setCategory(.playAndRecord)
            } catch {
                let audioError = YAudioError(error: error, des: String.audio_setCategoryFailed, code: String.audio_setCategoryFailedCode)
                seal.reject(audioError)
            }
            do {
                try audioSession.setActive(true)
            } catch {
                let audioError = YAudioError(error: error, des: String.audio_setActiveFailed, code: String.audio_setActiveFailedCode)
                seal.reject(audioError)
            }
            seal.fulfill(())
        }
    }

    private func _setUpRecord() -> Promise<Void> {
        return Promise { seal in
            guard let cafFullPath = _cafPath else {
                let error = YAudioError(error: nil, des: String.audio_creatSavaCAFFilePathFailed, code: String.audio_creatSavaCAFFilePathFailedCode)
                seal.reject(error)
                return
            }
            let settings = [AVFormatIDKey : NSNumber(value: kAudioFormatLinearPCM),
                            AVSampleRateKey : NSNumber(value: _rate),
                            AVNumberOfChannelsKey : NSNumber(value: 2),
                            AVLinearPCMBitDepthKey : NSNumber(value: 16),
                            AVEncoderAudioQualityKey : NSNumber(value: AVAudioQuality.high.rawValue)]
            do {
                try _recorder =  AVAudioRecorder(url: cafFullPath, settings: settings)
                _recorder?.isMeteringEnabled = true
                _recorder?.delegate = self
            } catch {
                let tError = YAudioError(error: error, des: String.audio_creatRecorderFailed, code: String.audio_creatRecorderFailedCode)
                seal.reject(tError)
            }
            seal.fulfill(())
        }
    }
    
    private func _converCAFToMP3(cafPath: URL, mp3Path: URL) {
        recordStatusRelay.accept(.convert)
        LameTool.conventToMp3(withCafFilePath: cafPath.path, mp3FilePath: mp3Path.path, sampleRate: _rate) { result in
            self.recordStatusRelay.accept(.success)
            let timeDuration = self._getAudioDuration(filePath: cafPath)
            self.mp3InfoRelay.accept((mp3Path, timeDuration))
            self._deleteCafFile(path: nil)
        }
    }
    
    private func _getAudioDuration(filePath: URL) -> Float {
        let asset = AVURLAsset(url: URL(fileURLWithPath: filePath.path))
        let duration = asset.duration
        return Float(CMTimeGetSeconds(duration))
    }
    
    private func _updateFilePath() -> Promise<Void> {
        return Promise { seal in
            let timeString = Date.y_timestampToString()
            _cafPath = URL(string: String.y_cachePath)?.appendingPathComponent(timeString + ".caf")
            _mp3Path = URL(string: String.y_cachePath)?.appendingPathComponent(timeString + ".mp3")
            seal.fulfill(())
        }
    }
    
    private func _clearnFilePath() {
        _cafPath = nil
        _mp3Path = nil
    }
    
    private func _deleteCafFile(path: URL?) {
        let usedPath = path ?? _cafPath
        guard let realPath = usedPath else {
            return
        }
        try? FileManager.default.removeItem(at: realPath)
    }
    
    private func _setUpTimer() {
        _timer = YGCDTimer.repeatTimer(interval: .milliseconds(100), handler: { [weak self] in
            guard let self = self, let recorder = self._recorder else {
                return
            }
            self._getVolume(recorder)
        }).fire()
    }
    
    private func _getVolume(_ recorder: AVAudioRecorder) {
        recorder.updateMeters()
        var level: Float
        let minDecibels: Float = -80
        let decibels = recorder.averagePower(forChannel: 0)
        if decibels < minDecibels {
            level = 0
        } else if decibels > 0 {
            level = 1
        } else {
            let root: Float = 2.0
            let minAmp = powf(10, 0.05*minDecibels)
            let inverseAmpRange = 1.0/(1.0 - minAmp)
            let amp = powf(10, 0.05*decibels)
            let adjAmp = (amp - minAmp) * inverseAmpRange
            level = powf(adjAmp, 1/root)
        }
        volumeRelay.accept(level)
    }
}

extension YAudioTool: AVAudioRecorderDelegate {
    public func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        recordStatusRelay.accept(.failed(reason: error?.localizedDescription))
        _clearnFilePath()
        _deleteCafFile(path: nil)
    }
    
    public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        guard let cafPath = _cafPath, let mp3Path = _mp3Path else {
            _clearnFilePath()
            return
        }
        switch recordStatusRelay.value {
        case .complete:
            _converCAFToMP3(cafPath: cafPath, mp3Path: mp3Path)
        default:
            _deleteCafFile(path: nil)
        }
        _clearnFilePath()
    }
}

