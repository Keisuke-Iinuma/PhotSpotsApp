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

class ViewController: UIViewController , CLLocationManagerDelegate , MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    
    // locationManager初期化
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //表示範囲
        //let span = MKCoordinateSpan (latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        //中心座標と表示範囲をマップに登録する。
        // let region = MKCoordinateRegionMake(center, span)
        //mapView.setRegion(region, animated:true)
        
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
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     //地図中心座標にピンを立てる。
     let center = mapView.centerCoordinate
     let annotation = MKPointAnnotation()
     annotation.coordinate = center
     mapView.addAnnotation(annotation)
     }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ImageSelectController" {
        }
        else{
            //地図中心座標にピンを立てる。
            let center = mapView.centerCoordinate
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            mapView.addAnnotation(annotation)
        }
    }
    
}

