//
//  CameraViewController+Flashlight.swift
//  ONEOnboard
//
//  Created by DENZA on 27/10/19.
//

import Foundation
import AVFoundation

extension CameraViewController {
    public func isFlashlightOn() -> Bool {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return false }
        guard device.hasTorch else { return false }
        do {
            try device.lockForConfiguration()
            return device.torchMode == AVCaptureDevice.TorchMode.on
        } catch {
            return false
        }
    }

    public func turnOnFlashlight(_ isTurnOn: Bool) {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }
        do {
            try device.lockForConfiguration()
            if isTurnOn {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            } else {
                device.torchMode = AVCaptureDevice.TorchMode.off
            }
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
}
