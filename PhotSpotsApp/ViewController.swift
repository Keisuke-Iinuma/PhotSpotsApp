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
import Firebase

class ViewController: UIViewController , CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    
    // locationManager初期化
    var locationManager = CLLocationManager()
    
    var pinView:MKPinAnnotationView!
    var sendText:String = ""
    var sendImage:UIImage!
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //表示範囲
        //let span = MKCoordinateSpan (latitudeDelta: 0.05, longitudeDelta: 0.05)
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = MKUserTrackingMode.followWithHeading
        
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
    
    /*override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
     // セグエのポップオーバー接続先を取得
     let popoverCtrl = segue.destination.popoverPresentationController
     // 呼び出し元がUIButtonの場合
     if sender is UIButton {
     // タップされたボタンの領域を取得
     popoverCtrl?.sourceRect = (sender as! UIButton).bounds
     }
     // デリゲートを自分自身に設定
     popoverCtrl?.delegate = self
     }
     
     // 表示スタイルの設定
     func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
     // .noneを設定することで、設定したサイズでポップオーバーされる
     return .none
     
     }*/
    
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


extension ViewController: MKMapViewDelegate ,UIPopoverPresentationControllerDelegate{
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
            imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            //pinView?.detailCalloutAccessoryView = imageView
            pinView?.rightCalloutAccessoryView = imageView
            //吹き出しの右側に配置するボタンを定義
            let rightButton = UIButton(type: .infoLight)        /*このaddTarget(_:action:for:)メソッドが、青い線を引っ張ってActionを設定する代わりになります。addTargetの第一引数に selfを設定することで、自分自身(ViewController)を呼び出し対象とし、第二引数(action:)の #selectorで指定したメソッドが呼び出すメソッドとなる。 #selector内で指定されている didClickDetailDisclosuren(for: .touchUpInside)は、メソッド名が rightButtonで、第一引数の外部引数名は省略(_)、第二引数の外部引数名はforEvent:を指定して呼び出すメソッドであることを意味しています。この場合、第一引数にはタップされたUIButtonのインスタンスが格納され、第二引数にはUIEvent型のタップイベントが格納されます。タップイベントの中には、ボタンをタップした時の画面上の座標位置などが格納されています。*/
            rightButton.addTarget(self, action: #selector(didClickDetailDisclosure), for: .touchUpInside)
            pinView?.rightCalloutAccessoryView = rightButton
            imageView.contentMode = .scaleAspectFit
        }
            
        else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    // @objc func showPopover(_ sender: UIBarButtonItem) {
    @objc func didClickDetailDisclosure(button: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(
            withIdentifier: "locationDetail")
        
        viewcontroller.modalPresentationStyle = .popover
        viewcontroller.popoverPresentationController?.sourceView = button
        viewcontroller.popoverPresentationController?.delegate = self
        viewcontroller.preferredContentSize = CGSize(width: 400, height: 600)
        //passthroughViews: [UIView]
        /*let height = yourDataArray.count * Int(popOverViewController.tableView.rowHeight)
         popOverViewController.preferredContentSize = CGSize(width: 300, height: height)*/
        // Present the view controller (in a popover).
        self.present(viewcontroller, animated: true) {
        }
    }
    
    /*func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle {
     // Return no adaptive presentation style, use default presentation behaviour
     return .none
     }*/
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, rightcalloutAccessoryControlTapped control: UIButton) {
    }
}

//もしポップオーバーに拘るのであれば下記を有効にする。
/*class MyPopoverBackgroundView: UIPopoverBackgroundView {
 
 //ポップオーバーのコンテンツ部分のインセット
 override static func contentViewInsets() -> UIEdgeInsets{
 return .zero
 }
 //底辺の矢印の三角形の幅
 override static func arrowBase() -> CGFloat{
 return 10
 }
 //矢印の基部から先端までの高さ
 override static func arrowHeight() -> CGFloat{
 return 10
 }
 }*/

