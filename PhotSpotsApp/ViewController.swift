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

class ViewController: UIViewController , CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    //表示範囲
    let span = MKCoordinateSpan (latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    // locationManager初期化
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
          super.viewDidLoad()
          
          self.mapView.showsUserLocation = true
          
          self.mapView.setUserTrackingMode(.follow, animated: true)
          
          mapView.isRotateEnabled = false
          
          //ロングタップしたときに立てるピンを定義
          var pinByLongPress:MKPointAnnotation!
          
          var locationManager: CLLocationManager!
          
          // 測位精度
          let locationAccuracy: [Double] = [
              kCLLocationAccuracyBestForNavigation,
              kCLLocationAccuracyBest,
              kCLLocationAccuracyNearestTenMeters,
              kCLLocationAccuracyHundredMeters,
              kCLLocationAccuracyKilometer,
              kCLLocationAccuracyThreeKilometers
          ]
          
          
          
          
          func locationManager(_ manager: CLLocationManager,
                               didUpdateLocations locations: [CLLocation]) {
              // 最初のデータ
              let location = locations.first
              
              // 緯度
              let latitude = location?.coordinate.latitude
              // 経度
              let longitude = location?.coordinate.longitude
              
              print("latitude: \(latitude!)")
              print("longitude: \(longitude!)")
          }
      }
    @IBAction func pressMap(_ sender: UILongPressGestureRecognizer) {
        //マップビュー内のタップした位置を取得する。
        let location:CGPoint = sender.location(in: mapView)
        
        if (sender.state == UIGestureRecognizer.State.ended){
            
            //タップした位置を緯度、経度の座標に変換する。
            let mapPoint:CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
            
            //ピンを作成してマップビューに登録する。
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
            annotation.title = "ピン"
            annotation.subtitle = "\(annotation.coordinate.latitude), \(annotation.coordinate.longitude)"
            mapView.addAnnotation(annotation)
            
        }
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
            locationManager.distanceFilter = 10
            // 位置情報の取得を開始
            locationManager.startUpdatingLocation()
        }
        
        
        
        func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
            
            let testView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            
            //吹き出しを表示可能にする。
            testView.canShowCallout = true
            
            return testView
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            
            if annotation === mapView.userLocation {
                // 現在地を示すアノテーションの場合はデフォルトのまま
                
                //現在地のタイトルをnilにすることでコールアウトを非表示にする
                (annotation as? MKUserLocation)?.title = nil
                
                return nil //nilを返すことで現在地がピンにならない
                
            } else {
                
                let identifier = "annotation"
                if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier){
                    // 再利用できる場合はそのまま返す
                    
                    return annotationView
                } else { // 再利用できるアノテーションが無い場合（初回など）は生成する
                    let myPinIdentifier = "PinAnnotationIdentifier"
                    
                    //ピンをインスタンス化
                    let pinByLongPress = MKPointAnnotation()
                    
                    //アノテーションビュー生成
                    let annotationView = MKPinAnnotationView(annotation: pinByLongPress, reuseIdentifier: myPinIdentifier)
                    
                    //ピンが降ってくるアニメーションをつける
                    annotationView.animatesDrop = true
                    
                    return annotationView
                }
            }
            
        }
    }
}
