//
//  ViewController.swift
//  Lotto
//
//  Created by 이지훈 on 5/10/25.
//

import UIKit

class ViewController: UIViewController {
    
    //Connection Well
    
   
    
    @IBOutlet weak var number1Label: UILabel!
    @IBOutlet weak var number2Label: UILabel!
    @IBOutlet weak var number3Label: UILabel!
    @IBOutlet weak var number4Label: UILabel!
    @IBOutlet weak var number5Label: UILabel!
    @IBOutlet weak var number6Label: UILabel!
    @IBOutlet weak var number7Label: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rnd1 = Int.random(in: 1 ... 45)
        number1Label.text = "\(rnd1)"
        switch rnd1 {
        case 1 ... 10 :
            number1Label.backgroundColor = UIColor.yellow
            number1Label.textColor = UIColor.black
        case 11 ... 20 :
            number1Label.backgroundColor = UIColor.blue
            number1Label.textColor = UIColor.white
        case 21 ... 30 :
            number1Label.backgroundColor = UIColor.red
            number1Label.textColor = UIColor.white
        case 31 ... 40 :
            number1Label.backgroundColor = UIColor.gray
            number1Label.textColor = UIColor.white
        case 41 ... 45 :
            number1Label.backgroundColor = UIColor.green
            number1Label.textColor = UIColor.black
        default:
            break
        }
        
        let rnd2 = Int.random(in: 1 ... 45)
        number2Label.text = "\(rnd2)"
        switch rnd2 {
        case 1 ... 10 :
            number2Label.backgroundColor = UIColor.yellow
            number2Label.textColor = UIColor.black
        case 11 ... 20 :
            number2Label.backgroundColor = UIColor.blue
            number2Label.textColor = UIColor.white
        case 21 ... 30 :
            number2Label.backgroundColor = UIColor.red
            number2Label.textColor = UIColor.white
        case 31 ... 40 :
            number2Label.backgroundColor = UIColor.gray
            number2Label.textColor = UIColor.white
        case 41 ... 45 :
            number2Label.backgroundColor = UIColor.green
            number2Label.textColor = UIColor.black
        default:
            break
        }
        
        let rnd3 = Int.random(in: 1 ... 45)
        number3Label.text = "\(rnd2)"
        switch rnd3 {
        case 1 ... 10 :
            number3Label.backgroundColor = UIColor.yellow
            number3Label.textColor = UIColor.black
        case 11 ... 20 :
            number3Label.backgroundColor = UIColor.blue
            number3Label.textColor = UIColor.white
        case 21 ... 30 :
            number3Label.backgroundColor = UIColor.red
            number3Label.textColor = UIColor.white
        case 31 ... 40 :
            number3Label.backgroundColor = UIColor.gray
            number3Label.textColor = UIColor.white
        case 41 ... 45 :
            number3Label.backgroundColor = UIColor.green
            number3Label.textColor = UIColor.black
        default:
            break
        }
        
        let rnd4 = Int.random(in: 1 ... 45)
        number4Label.text = "\(rnd4)"
        switch rnd4 {
        case 1 ... 10 :
            number4Label.backgroundColor = UIColor.yellow
            number4Label.textColor = UIColor.black
        case 11 ... 20 :
            number4Label.backgroundColor = UIColor.blue
            number4Label.textColor = UIColor.white
        case 21 ... 30 :
            number4Label.backgroundColor = UIColor.red
            number4Label.textColor = UIColor.white
        case 31 ... 40 :
            number4Label.backgroundColor = UIColor.gray
            number4Label.textColor = UIColor.white
        case 41 ... 45 :
            number4Label.backgroundColor = UIColor.green
            number4Label.textColor = UIColor.black
        default:
            break
        }
        
        let rnd5 = Int.random(in: 1 ... 45)
        number5Label.text = "\(rnd5)"
        switch rnd5 {
        case 1 ... 10 :
            number5Label.backgroundColor = UIColor.yellow
            number5Label.textColor = UIColor.black
        case 11 ... 20 :
            number5Label.backgroundColor = UIColor.blue
            number5Label.textColor = UIColor.white
        case 21 ... 30 :
            number5Label.backgroundColor = UIColor.red
            number5Label.textColor = UIColor.white
        case 31 ... 40 :
            number5Label.backgroundColor = UIColor.gray
            number5Label.textColor = UIColor.white
        case 41 ... 45 :
            number5Label.backgroundColor = UIColor.green
            number5Label.textColor = UIColor.black
        default:
            break
        }
        
        let rnd6 = Int.random(in: 1 ... 45)
        number6Label.text = "\(rnd6)"
        switch rnd6 {
        case 1 ... 10 :
            number6Label.backgroundColor = UIColor.yellow
            number6Label.textColor = UIColor.black
        case 11 ... 20 :
            number6Label.backgroundColor = UIColor.blue
            number6Label.textColor = UIColor.white
        case 21 ... 30 :
            number6Label.backgroundColor = UIColor.red
            number6Label.textColor = UIColor.white
        case 31 ... 40 :
            number6Label.backgroundColor = UIColor.gray
            number6Label.textColor = UIColor.white
        case 41 ... 45 :
            number6Label.backgroundColor = UIColor.green
            number6Label.textColor = UIColor.black
        default:
            break
        }
        
        let rnd7 = Int.random(in: 1 ... 45)
        number7Label.text = "\(rnd7)"
        number7Label.backgroundColor = UIColor.purple
        number7Label.textColor = UIColor.white
        
//        number1Label.text = "\(Int.random(in: 1 ... 45))"
//        number2Label.text = "\(Int.random(in: 1 ... 45))"
//        number3Label.text = "\(Int.random(in: 1 ... 45))"
//        number4Label.text = "\(Int.random(in: 1 ... 45))"
//        number5Label.text = "\(Int.random(in: 1 ... 45))"
//        number6Label.text = "\(Int.random(in: 1 ... 45))"
//        number7Label.text = "\(Int.random(in: 1 ... 45))"
        
        
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let labels = [number1Label, number2Label, number3Label, number4Label, number5Label, number6Label, number7Label]
        
        for label in labels {
                label?.layer.cornerRadius = label!.bounds.width / 2
                label?.clipsToBounds = true
            }
    }


}

