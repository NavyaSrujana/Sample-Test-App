//
//  ViewController.swift
//  Task
//
//  Created by NAVYA on 11/22/16.
//  Copyright © 2016 NAVYA. All rights reserved.
//

import UIKit
import Koloda

private var numberOfCards: UInt = 6

class ViewController: UIViewController {

    
    @IBOutlet var kolodaView: KolodaView!
    
     var dataSource: Array<UIImage> = {
        var array: Array<UIImage> = []
        for index in 0..<numberOfCards {
            array.append(UIImage(named: "Card_like_\(index + 1)")!)
        }
        
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        kolodaView.delegate = self
        kolodaView.dataSource = self
        
    }
    
    
    @IBAction func leftBtnTapped(_ sender: AnyObject) {
        
        kolodaView?.swipe(direction: SwipeResultDirection.Left)

    }
    
        @IBAction func rightBtnTapped(_ sender: AnyObject) {
        
        kolodaView?.swipe(direction: SwipeResultDirection.Right)

    }

    @IBAction func undoBtnTapped(_ sender: AnyObject) {
        kolodaView?.revertAction()
    }
    
}


    //MARK: KolodaViewDelegate
    extension ViewController: KolodaViewDelegate {
        
        func kolodaDidRunOutOfCards(koloda: KolodaView) {
            
            dataSource.insert(UIImage(named: "Card_like_6")!, at: kolodaView.currentCardIndex - 1)
            let position = kolodaView.currentCardIndex
            kolodaView.insertCardAtIndexRange(indexRange: position..<position+1, animated: true)
        }
        
    }
    
    //MARK: KolodaViewDataSource
    extension ViewController: KolodaViewDataSource {
        
        func kolodaNumberOfCards(koloda:KolodaView) -> UInt {
            return UInt(dataSource.count)
        }
        
        func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
            return UIImageView(image: dataSource[Int(index)])
        }
        
    }


