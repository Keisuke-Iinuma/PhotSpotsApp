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
    var sendImage:UIImageView
    
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
            
            pinView?.animatesDrop = true
            //ピンのアニメーションをONにする。
            pinView?.animatesDrop = true
            //吹き出しを表示可能に。
            pinView?.canShowCallout = true
            
            let customerImage = sendImage
            let rightImageView = UIImageView(image: UIImage(named: "customerImage"))
            rightImageView.frame = CGRect(x: 0, y: 200, width: 100, height: 100)
            rightImageView.contentMode = .scaleAspectFit
            pinView?.detailCalloutAccessoryView = rightImageView
            
            
            /*let button = UIButton()
            button.frame = CGRect(x:0,y:0,width:100,height:40)
            button.setTitle("ここに行く", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor.darkGray
            button.addTarget(self, action: #selector(sendLocation), for: .touchUpInside)
            //右側にボタンを追加
            pinView?.rightCalloutAccessoryView = button*/
        }
        else {
            pinView?.annotation = annotation
        }
        return pinView
    }
}

//目的地に設定ボタン押下時の処理
/*@objc func sendLocation(){
    
    /*let sourcePlaceMark = MKPlacemark(coordinate: UserLocation)
     let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
     
     let directionRequest = MKDirections.Request()
     directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
     directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
     directionRequest.transportType = .automobile
     
     let directions = MKDirections(request: directionRequest)
     directions.calculate { (response, error) in
     guard let directionResonse = response else {
     if let error = error {
     print("we have error getting directions==\(error.localizedDescription)")
     }
     return
     }
     //　ルートを追加
     let route = directionResonse.routes[0]
     self.mapView.addOverlay(route.polyline, level: .aboveRoads)
     //　縮尺を設定
     let rect = route.polyline.boundingMapRect
     self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
     }
     
     //set delegate for mapview
     self.mapView.delegate = self
     }
     
     func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
     let renderer = MKPolylineRenderer(overlay: overlay)
     renderer.strokeColor = UIColor.blue
     renderer.lineWidth = 4.0
     return renderer*/
    
}
*/
