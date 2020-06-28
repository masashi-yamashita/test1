//
//  GoogleMapViewController.swift
//  Random-Restaurant
//
//  Created by 山下将司 on 6/28/20.
//  Copyright © 2020 mashi. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class GoogleMapViewController: UIViewController,CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    
    //ViewControllerから値を持ってきて下の箱に入れる。
    var latitude = String()
    var longitude = String()
    var name = String()
    var address = String()

    @IBOutlet weak var backButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()

     //初期位置の設定
     //初期のポジション（東京駅）
     let camera = GMSCameraPosition.camera(withLatitude:35.6812226, longitude:139.7670594, zoom:12)
             
     let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
             
     let map = GMSMapView()
     map.animate(toViewingAngle: 45)
     //位置情報の取得が許可されたらユーザーの現在地を表示する
     mapView.isMyLocationEnabled = true
     
     //自分自身のViewにmapViewを表示する
     self.view = mapView
             
     //CLLocationCoordinate2DにはDouble型しか入らないので、Stirng型のlatitudeをDouble型に変更
     let markerLatitude: Double = atof(latitude)
     let markerLongitude: Double = atof(longitude)
     
     //得られた位置情報にマーカーをつける
     let marker = GMSMarker()
     marker.position = CLLocationCoordinate2D(latitude: markerLatitude, longitude: markerLongitude)
     marker.title = name
     marker.snippet = address
     marker.map = mapView
             

    }

    // ユーザにアプリ使用中のみ位置情報取得の許可を求めるダイアログを表示
    func setUpLocationManager(){
        locationManager = CLLocationManager()
        locationManager.delegate = self

        guard let locationManager = locationManager else { return }
        locationManager.requestWhenInUseAuthorization()

        //位置情報取得の許可が下りた時、
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {

            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()

    }
    }
    
    // 位置情報を取得・更新するたびに呼ばれる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        //取得した位置情報(locations)を緯度経度に分ける
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude

        print("latitude: \(latitude!)\nlongitude: \(longitude!)")
        //↑現在位置情報の取得に成功！！　これを基にぐるなびの検索をかける！！

    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    

}
