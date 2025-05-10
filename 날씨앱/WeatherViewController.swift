//
//  ViewController.swift
//  SunnyDay
//
//  Created by 이지훈 on 5/9/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func getWeatherImage(matching weather : String) -> UIImage? {
        switch weather {
        case "맑음" :
            return UIImage(named: "016-sun")
        case "흐림" :
            return UIImage(named: "001-cloud")
        case "눈" :
            return UIImage(named: "004-cloud")
        case "비" :
            return UIImage(named: "002-cloud")
        default :
            return nil
        }
    }
    
    func getTemperatureDescription(mathing temperature : Int) -> String? {
        switch temperature {
        case ..<(-10) :
            return "이불밖은 위험해"
        case -10 ... 10 :
            return "두툼한 패딩을 챙기세요"
        case 11 ... 20 :
            return "자외선 차단제를 꼭 챙기세요"
        case 21 ... 30 :
            return "모기냄새가 나요"
        case 31...:
            return "덥네요"
        default :
            return nil
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*
         nil coalescing operator
         nil   병합 연산자
         operator_expr ?? b
         왼쪽이 존재한다면 반환하고 아니면 b 반환
         */
        
        
        let weather = ["맑음","흐림","눈","비"].randomElement() ?? "맑음"
        let tempertaure = Int.random(in: -10 ... 38 )
        
       
       
        weatherImageView.image = getWeatherImage(matching: weather)
        statusLabel.text = weather
        temperatureLabel.text = "\(tempertaure)℃"
        descriptionLabel.text = getTemperatureDescription(mathing: tempertaure)
        
        
        
    }
    
    
  
    
    
    

}

