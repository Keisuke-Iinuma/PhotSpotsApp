//
//  DetailController.swift
//  PhotSpotsApp
//
//  Created by 飯沼圭哉 on 2020/08/12.
//  Copyright © 2020 keisuke.iinuma. All rights reserved.
//

import UIKit
import MapKit
import FirebaseUI

class DetailController: UIViewController ,MKMapViewDelegate{
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var sendImage:UIImage!
    // 投稿データを格納する配列
    var postArray: [PostData] = []
    
    @IBAction func destinationButtonTap(_ sender: Any) {
    }
    @IBAction func deletePinButtonTap(_ sender: Any) {
    }
    @IBAction func reportButtontap(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // UIImage インスタンスの生成
        let image = sendImage
        // UIImageView 初期化
        let imageView = UIImageView(image:image)
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        //imageView.
        
        // 元のバックのビューは、とりあえず透明にして見えなくする
        /*view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        // UIVisualEffectViewを生成する
        let visualEffectView = UIVisualEffectView(frame: view.frame)
        // エフェクトの種類を設定
        visualEffectView.effect = UIBlurEffect(style: .light)
        // UIVisualEffectViewを他のビューの下に挿入する
        view.insertSubview(visualEffectView, at: 0)*/
    }
    
    //func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  return postArray.count
    //}

    //func tableView(_ tableView: UIViewController, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得してデータを設定する
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostViewController
        //cell.setPostData(postArray[indexPath.row])

        //return cell
    //}
    
    //ここから経路検索のコード記述
    /*func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView, didUpdateLocations locations: [CLLocation]) {
     
     let sourceCooridanate = MKUserLocation.self
     let destCoordinate = view.annotation!
     
     let location = locations[0]
     let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
     let myLocation = location.coordinate
     
     let sourcePlaceMark = MKCoordinateRegion(center: myLocation, span: span)
     let destPlaceMark = MKPlacemark(coordinate: destCoordinate as! CLLocationCoordinate2D)
     
     let directionRequest = MKDirections.Request()
     directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
     directionRequest.destination = MKMapItem(placemark: destPlaceMark)
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
     mapView.addOverlay(route.polyline, level: .aboveRoads)
     //　縮尺を設定
     let rect = route.polyline.boundingMapRect
     mapView.setRegion(MKCoordinateRegion(rect), animated: true)
     }
     //set delegate for mapview
     mapView.delegate = self
     }
     
     func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
     let renderer = MKPolylineRenderer(overlay: overlay)
     renderer.strokeColor = UIColor.blue
     renderer.lineWidth = 4.0
     return renderer
     }*/
    //ここまで経路検索の記述
    
    // PostDataの内容をセルに表示
    func setPostData(_ postData: PostData) {
        // 画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)
        
        // キャプションの表示
        //self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
        // 日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }
        
        // いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        // いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


