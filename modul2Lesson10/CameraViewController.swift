//
//  CameraViewController.swift
//  modul2Lesson10
//
//  Created by Давид Узунян on 13.01.2024.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    //1 session
    var session: AVCaptureSession!
    //2 preview
    var preview: AVCaptureVideoPreviewLayer!
    //3 output
    var output = AVCapturePhotoOutput()
    
    lazy var shotBtn: UIButton = {
        $0.frame = CGRect(x: view.center.x - 25, y: view.frame.height - 80 , width: 50, height: 50)
        $0.setBackgroundImage(UIImage(systemName: "camera"), for: .normal)
        //        $0.backgroundColor = .blue
        return $0
    }(UIButton(primaryAction: action))
    
    private lazy var action = UIAction { _ in
        
        let setting = AVCapturePhotoSettings()
        setting.flashMode = .on
        self.output.capturePhoto(with: setting, delegate: self)
    }
    
    lazy var imageView: UIImageView = {
        $0.frame = CGRect(x: view.frame.width - 100, y: view.frame.height - 120, width: 80, height: 80)
        $0.backgroundColor = .green
        $0.layer.cornerRadius = 40
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.addGestureRecognizer(tapGests)
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    lazy var tapGests: UITapGestureRecognizer = {
        $0.addTarget(self, action: #selector(tapGestFunc(sender: )))
        return $0
    }(UITapGestureRecognizer())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCamera()
        view.addSubview(imageView)
        view.addSubview(shotBtn)
    }
    
    @objc func tapGestFunc(sender: UITapGestureRecognizer) {
        if let image = imageView.image {
            LastShotController(with: image)
        }
    }
    
    private func LastShotController(with image: UIImage) {
        print("test tap")
        let photoDetailVC = LastShot()
        photoDetailVC.receivedImage = image
        navigationController?.pushViewController(photoDetailVC, animated: true)
    }
    
    private func createCamera(){
        session = AVCaptureSession()
        session.sessionPreset = .hd4K3840x2160 //настройка качества видео
        guard let device = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back) else {
            print("нет камеры")
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input), session.canAddOutput(output) {
                session.addInput(input)
                session.addOutput(output)
            }
            
            preview = AVCaptureVideoPreviewLayer(session: session)
            preview.videoGravity = .resizeAspect //вид отображения превью
            
            //через диспетчеризацию глобал
            DispatchQueue.global(qos: .userInitiated).async { //qos - приоритеты
                self.session.startRunning()
            }
            preview.frame = view.bounds
            view.layer.addSublayer(preview)
            
        } catch {
            print("error")
        }
    }
    
}
extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else { return }
        if let image = UIImage(data: data) {
            self.imageView.image = image
            
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            
        }
    }
}
