//
//  GurunabiSearchViewController.swift
//  Random-Restaurant
//
//  Created by 山下将司 on 6/28/20.
//  Copyright © 2020 mashi. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class GurunabiSearchViewController: UIViewController,CLLocationManagerDelegate, UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate {

    var locationManager: CLLocationManager!
    
    var latitude = Double()
    var longitude = Double()
    
    var gurunabiName = String()
    var gurunabiLatitude = String()
    var gurunabiLongitude = String()
    var gurunabiAddress = String()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.placeholder = "料理名を入力してください"
        
        tableView.dataSource = self
        tableView.delegate = self

        //起動した時に、位置情報が取得される
        setUpLocationManager()

        
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
        latitude = location?.coordinate.latitude as! Double
        longitude = location?.coordinate.longitude as! Double

        print("latitude: \(latitude)\nlongitude: \(longitude)")
        //↑現在位置情報の取得に成功！！　これを基にぐるなびの検索をかける！！
                
    }
    
    //タプルを作成。タプル=複数の値を1つの変数として設定する(= name,category,tel,addressをひとまとめにする)
    var gurunabiList : [(name:String , category:String , url_mobile:URL , address:String ,latitude:String , longitude:String) ] = []
    
    
    //searchBarがクリックされた時の動き
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
      view.endEditing(true)
        
        if let searchWord = searchBar.text {
            
            print(searchWord)
         
            //searchWordと位置情報をぐるなびへ代入
            searchGurunabi(keyword: searchWord)

        }

    }
    //RestJsonは個別情報(名前、カテゴリー電話番号、住所)が入る
       struct RestJson: Codable {
           
           //店名
           let name: String?
           //カテゴリー
           let category: String?
           //モバイルURL
           let url_mobile: URL?
           //住所
           let address: String?
           //緯度
           let latitude: String?
           //経度
           let longitude: String?

           
       }
       //ResultJsonは複数の情報を配列でまとめて管理する構造体
       struct ResultJson: Codable {
           
           //個別情報をまとめて管理
           let rest:[RestJson]?
       }
       
       //ぐるなびで検索をする
       func searchGurunabi(keyword : String) {
           
           guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
               return
           }
           
           //キーワードと緯度経度を代入して、リクエストURLの組み立てる。
           guard let req_url = URL(string: "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=c88f610bf431b210a3c8268c583ef221&latitude=\(latitude)&longitude=\(longitude)&range=&freeword=\(keyword_encode)&hit_per_page=5") else{
               return
           }
           
           print(req_url)
           
           
           //リクエスト先(req)を(urlとして)設定。
           let req = URLRequest(url: req_url)
           
           //URLSession(バックグラウンド通信や中断した通信を再生させる機能あり)を生成
           let session = URLSession(configuration: .default, delegate: nil,delegateQueue: OperationQueue.main)
           print(session)
           
           //.dataTaskメソッドでリクエスト処理を実行しなければならない処理として登録する
           let task = session.dataTask(with: req, completionHandler: {
               (data, response, error) in
               
               session.finishTasksAndInvalidate()

               do {
                   
                   let decoder = JSONDecoder()
                   //jsonの中に、dataから受け取ったjsonデータをパースして格納。decoder.decodeで受け取ったデータを解析する。
                   let json = try decoder.decode(ResultJson.self, from: data!)

                   print(json)
                   
                   //タプル設定後、お店の情報が取得できているか確認「json.restにお菓子の情報が格納されている」
                   if let rests = json.rest {
               
                       self.gurunabiList.removeAll()
                       
                       //restsの中に入っているrestの数だけ処理を実施する(=5回)
                       for rest in rests {
                           if let name = rest.name, let category = rest.category, let url = rest.url_mobile, let address = rest.address, let latitude
                               = rest.latitude, let longitude = rest.longitude {
                               
                               //お店の情報をまとめて管理
                               let gurunabiStoreInfomation = (name,category,url,address,latitude,longitude)
                         
                               //まとめたお店の情報をタプルへ追加
                               self.gurunabiList.append(gurunabiStoreInfomation)
                               
                           }
                       }
                       //TableViewを更新する
                       self.tableView.reloadData()
                       
                       if let gurunabidbg = self.gurunabiList.first {

                           print("gurunabiList[0] = \(gurunabidbg)")
                           
                       }
                       
                   }
                   
               } catch {

                   print("エラーだよ")
               }

           } )

           //ダウンロード開始
           task.resume()

       }

       //cellの総数を返すdatasourceメソッド。必ず記述。行数。
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
           //ぐるなびリストの総数をカウントする
           return gurunabiList.count

       }
       //cellに値を表示するメソッド。
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           //今回表示を行うCellオブジェクト(1行)を取得する
           var cell = tableView.dequeueReusableCell(withIdentifier: "gurunabiInfomation", for: indexPath)
           
           cell = UITableViewCell(style: .subtitle, reuseIdentifier: "gurunabiInfomation")
           cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
           cell.textLabel?.text = gurunabiList[indexPath.row].name
           cell.detailTextLabel?.text = gurunabiList[indexPath.row].category
           
           return cell
           
       }
       func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
           
           tableView.deselectRow(at: indexPath, animated: true)
           
            gurunabiName = gurunabiList[indexPath.row].name
            gurunabiLatitude = gurunabiList[indexPath.row].latitude
            gurunabiLongitude = gurunabiList[indexPath.row].longitude
            gurunabiAddress = gurunabiList[indexPath.row].address
           
           //これらをgooglemap上に移動させる
           print(gurunabiName)
           print(gurunabiLatitude)
           print(gurunabiLongitude)
           print(gurunabiAddress)
           
           //お店がタップされたときにNextVCへ画面遷移をする。
        performSegue(withIdentifier: "googlemap", sender: nil)

       }

       //NextVCへ画面遷移されたときに、各種値も移す
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           let GMVC:GoogleMapViewController = segue.destination as! GoogleMapViewController
           GMVC.name = gurunabiName
           GMVC.latitude = gurunabiLatitude
           GMVC.longitude = gurunabiLongitude
           GMVC.address = gurunabiAddress

       }
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    

    


}
