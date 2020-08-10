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

class ViewController: UIViewController , CLLocationManagerDelegate , UISearchBarDelegate , MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    
    // locationManager初期化
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //表示範囲
        let span = MKCoordinateSpan (latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        //中心座標と表示範囲をマップに登録する。
       // let region = MKCoordinateRegionMake(center, span)
        //mapView.setRegion(region, animated:true)
        
        //SearchBar.delegate = self as? UISearchBarDelegate
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
        
        // 測位精度
        let locationAccuracy: [Double] = [
            kCLLocationAccuracyBestForNavigation,
            kCLLocationAccuracyBest,
            kCLLocationAccuracyNearestTenMeters,
            kCLLocationAccuracyHundredMeters,
            kCLLocationAccuracyKilometer,
            kCLLocationAccuracyThreeKilometers
        ]
        
        //let annotation = MKPointAnnotation()
        //annotation.coordinate = CLLocationCoordinate2D
        //  mapView.addAnnotation(annotation)
        
        //ロングタップしたときに立てるピンを定義
        var pinByLongPress:MKPointAnnotation!
        
        var locationManager: CLLocationManager!
        
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
    
    
    /*func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //if (annotation is MKUserLocation) {
            // ユーザの現在地の青丸マークは置き換えない
          //  return nil
        //} else {
            let reuseId = "Pin"
            var av = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            if av == nil {
                av = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            }
            av?.image = UIImage.init(named: "053920.png")
            av?.annotation = annotation
            
            return av
        //}
    }*/
    
    /*func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
     if (annotation is MKUserLocation) {
     // ユーザの現在地の青丸マークは置き換えない
     return nil
     } else {
     // CustomAnnotationの場合に画像を配置
     let identifier = "Pin"
     var annotationView: MKAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
     if annotationView == nil {
     annotationView = MKAnnotationView.init(annotation: annotation, reuseIdentifier: identifier)
     }
     annotationView?.image = UIImage.init(named: "053920") // 任意の画像名
     annotationView?.annotation = annotation
     annotationView?.canShowCallout = true  // タップで吹き出しを表示
     return annotationView
     }
     }*/
    
    /*@IBAction func pressMap(_ sender: UILongPressGestureRecognizer) {
     
     
     //マップビュー内のタップした位置を取得する。
     let location:CGPoint = sender.location(in: mapView)
     
     if (sender.state == UIGestureRecognizer.State.ended){
     
     //タップした位置を緯度、経度の座標に変換する。
     let mapPoint:CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
     
     //ピンを作成してマップビューに登録する。
     let annotation = MKPointAnnotation()
     annotation.coordinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
     //annotation.title = "ピン"
     //annotation.subtitle = "\(annotation.coordinate.latitude), \(annotation.coordinate.longitude)"
     mapView.addAnnotation(annotation)
     
     }*/
    
    
    /*func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
     
     let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
     
     //吹き出しを表示可能にする。
     pinView.canShowCallout = true
     
     //右ボタンをアノテーションビューに追加する。
     let button1 = UIButton()
     button1.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
     button1.setTitle("スポットを追加", for: [])
     //button1.backgroundColor = UIColor.redColor()
     //button1.setTitleColor(UIColor.whiteColor(), for:.Normal)
     pinView.rightCalloutAccessoryView = button1
     
     return pinView
     }
     
     func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
     
     if(control == view.rightCalloutAccessoryView) {
     //左のボタンが押された場合はピンの色をランダムに変更する。
     //if let pinView = view as? MKPinAnnotationView {
     //  pinView.pinTintColor = UIColor(red: CGFloat(drand48()),
     //        green: CGFloat(drand48()),
     //      blue: CGFloat(drand48()),
     //    alpha: 1.0)
     //}
     //} else {
     
     //右のボタンが押された場合はピンを消す。
     mapView.removeAnnotation(view.annotation!)
     }
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
     
     //検索ボタン押下時の呼び出しメソッド
     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
     
     //キーボードを閉じる。
     SearchBar.resignFirstResponder()
     
     //検索条件を作成する。
     let request = MKLocalSearch.Request()
     request.naturalLanguageQuery = SearchBar.text
     
     //検索範囲はマップビューと同じにする。
     request.region = mapView.region
     
     //ローカル検索を実行する。
     let localSearch:MKLocalSearch = MKLocalSearch(request: request)
     localSearch.start(completionHandler: {(result, error) in
     
     for placemark in (result?.mapItems)! {
     if(error == nil) {
     
     //検索された場所にピンを刺す。
     let annotation = MKPointAnnotation()
     annotation.coordinate = CLLocationCoordinate2DMake(placemark.placemark.coordinate.latitude, placemark.placemark.coordinate.longitude)
     annotation.title = placemark.placemark.name
     annotation.subtitle = placemark.placemark.title
     
     self.mapView.addAnnotation(annotation)
     
     } else {
     //エラー
     print(error!)
     }
     }
     })
     }*/
    
    
}

extension MKPlacemark {
    var address: String {
        let components = [self.administrativeArea, self.locality, self.thoroughfare, self.subThoroughfare]
        return components.compactMap { $0 }.joined(separator: "")
    }
}

