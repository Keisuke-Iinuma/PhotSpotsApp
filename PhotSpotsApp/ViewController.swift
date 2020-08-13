//
//  ViewController.swift
//  PhotSpotsApp
//
//  Created by 飯沼圭哉 on 2020/08/08.
//  Copyright © 2020 keisuke.iinuma. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    
    // locationManager初期化
    var locationManager = CLLocationManager()
    
    var pinView:MKPinAnnotationView!
    var sendText:String = ""
    var sendImage:UIImage!
    //var sendImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //表示範囲
        //let span = MKCoordinateSpan (latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        self.mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(.follow, animated: true)
        self.mapView.userTrackingMode = MKUserTrackingMode.follow
        
        //デリゲート先に自分を設定する。
        mapView.delegate = self
        //地図が回転しないようにする。
        mapView.isRotateEnabled = false
        // ユーザーの使用許可を確認
        locationManager.requestWhenInUseAuthorization()
        // 使用許可に対するステータス
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            // delegateを設定
            locationManager.delegate = self
            // 測位精度の設定
            //locationManager.desiredAccuracy = locationAccuracy[1]
            // アップデートする距離半径(m)
            locationManager.distanceFilter = 5
            // 位置情報の取得を開始
            locationManager.startUpdatingLocation()
        }
        
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        // 他の画面から segue を使って戻ってきた時に呼ばれる
        let center = mapView.centerCoordinate
        let annotation = MKPointAnnotation()
        //ピンにメッセージを付随する
        let result = sendText
        annotation.title = "\(result)"
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
        
    }
}

extension ViewController: MKMapViewDelegate{
    //アノテーションビューを返すメソッド
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        //アノテーションビューを作成する。
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            //ピンのアニメーションをONにする。
            pinView?.animatesDrop = true
            //吹き出しを表示可能に。
            pinView?.canShowCallout = true
            
            // UIImage インスタンスの生成
            let image = sendImage
            // UIImageView 初期化
            let imageView = UIImageView(image:image)
            imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
            pinView?.detailCalloutAccessoryView = imageView
            //pinView?.rightCalloutAccessoryView = imageView
            imageView.contentMode = .scaleAspectFit
            
        }
        else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
           for view in views {
            view.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
            
            view.leftCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
            
           }
    }
}
