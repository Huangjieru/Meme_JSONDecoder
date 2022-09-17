//
//  MemeViewController.swift
//  Meme_JSONDecoder
//
//  Created by jr on 2022/9/16.
//

import UIKit
import Kingfisher

class MemeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var timelabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

                
        let url =  URL(string: "https://memes.tw/wtf/api")!
        //向伺服器發出請求，取得網址的data
            URLSession.shared.dataTask(with: url) { data, response, error in
                //假如有取得data(二進位資料)
               if let data = data{
                   //用JSONDecoder解譯成我們懂的語言樣貌
                    let decoder = JSONDecoder()
                   //JSON的key對應有底線的property,利用convertFromSnakeCase轉換成自訂型別->無底線
                   decoder.keyDecodingStrategy = .convertFromSnakeCase
                   //JSONDecoder 解析時間的 DateDecodingStrategy
                   let dataFormatter = DateFormatter()
                   dataFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                   decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.formatted(dataFormatter)
                   //轉換成想要的時間樣式
                   let outputFormatter = DateFormatter()
                   outputFormatter.dateFormat = "yyyy年MM月dd日 HH時mm分ss秒"
                   do{
                       //亂數取得資料內容
                       let index = Int.random(in: 0...19)
                           
                       //用decode函式取得資料。此函式有throws拋出錯誤，所以要加入do, catch。第一個參數是取得自訂型別的資料(第一層是array);第二個參數是data資料。
                       let meme = try decoder.decode([Meme].self, from: data)
                       //非同步執行
                       DispatchQueue.main.async {
                           //加入Kingfisher package可連結網頁圖片
                           self.imageView.kf.setImage(with: meme[index].src)
                           //meme類別
                           self.label.text = meme[index].contest.name
                           //時間
                           self.timelabel.text = outputFormatter.string(from: meme[index].createdAt.dateTimeString)
                          
                       }
                       
                   }catch{
                       print(error)
                   }
            }
            }.resume() //啟動URLSession請求
    
    
    }
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
