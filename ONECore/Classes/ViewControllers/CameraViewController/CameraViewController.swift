//
//  CameraViewController.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 24/10/19.
//

import UIKit
import AVFoundation

open class CameraViewController: TableViewController {
    override open var backgroundColor: UIColor { return UIColor.black }
    override open var tableViewBackgroundColor: UIColor { return UIColor.clear }
    private var imageOutput: AVCaptureStillImageOutput = AVCaptureStillImageOutput()
    private var session: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var isTakingPhoto: Bool = false
    public weak var delegate: CameraViewControllerDelegate?
    public var overlayLayer: CAShapeLayer?
    public var canvasFrame: CGRect?

    override open func viewDidLoad() {
        super.viewDidLoad()
        initCamera()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startCameraSession()
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopCameraSession()
    }

    override open func stylingNavigation() {
        super.stylingNavigation()
        navigationController?.applyTransparentStyle()
        view.backgroundColor = backgroundColor
    }

    private func initCamera() {
        initImageOutput()
        initSession()
        initVideoPreviewLayer()
    }

    private func initImageOutput() {
        imageOutput = AVCaptureStillImageOutput()
        imageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
    }

    private func initSession() {
        guard let deviceInput = getDeviceInput() else { return }
        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSession.Preset.photo
        session.addInput(deviceInput)
        if !session.canAddOutput(imageOutput) { return }
        session.addOutput(imageOutput)
        self.session = session
    }

    private func initVideoPreviewLayer() {
        guard let session = session else { return }
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        DispatchQueue.main.async {
            videoPreviewLayer.frame = self.contentView.bounds
            if videoPreviewLayer.superlayer == nil {
                self.contentView.layer.addSublayer(videoPreviewLayer)
            }
            self.videoPreviewLayer = videoPreviewLayer
        }
    }

    private func startCameraSession() {
        guard let session = session else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            session.startRunning()
            self.isTakingPhoto = false
        }
    }

    private func stopCameraSession() {
        guard let session = session else { return }
        session.stopRunning()
    }

    private func getDeviceInput() -> AVCaptureDeviceInput? {
        guard let primaryCamera = AVCaptureDevice.default(for: AVMediaType.video) else { return nil }
        var deviceInput: AVCaptureDeviceInput?
        do {
            deviceInput = try AVCaptureDeviceInput(device: primaryCamera)
        } catch _ as NSError {}
        return deviceInput
    }

    private func getVideoConnection() -> AVCaptureConnection? {
        for connecton in self.imageOutput.connections {
            for inputPort in connecton.inputPorts {
                if inputPort.mediaType == AVMediaType.video {
                    return connecton as AVCaptureConnection
                }
            }
        }
        return nil
    }

    public func takePhoto() {
        if isTakingPhoto { return }
        isTakingPhoto = true
        DispatchQueue.global(qos: .default).async {
            self.captureOutput()
        }
    }

    private func captureOutput() {
        guard let videoConnection = self.getVideoConnection() else { return }
        imageOutput.captureStillImageAsynchronously(from: videoConnection) {
            (sampleBuffer: CMSampleBuffer?, _) in
            guard let sampleBuffer = sampleBuffer else { return }
            self.stopCameraSession()
            guard let data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(
                sampleBuffer
            ) else { return }
            guard let image = UIImage(data: data) else { return }
            var croppedImage = image.crop(frameSize: self.contentView.bounds.size)
            if let canvasFrame = self.canvasFrame {
                croppedImage = croppedImage.crop(frameSize: canvasFrame.size)
            }
            DispatchQueue.main.async {
                self.delegate?.cameraViewControllerDidTakePicture(
                    originalImage: image,
                    croppedImage: croppedImage
                )
            }
        }
    }
}
