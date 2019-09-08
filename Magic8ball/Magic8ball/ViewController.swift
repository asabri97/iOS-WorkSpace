//
//  ViewController.swift
//  Magic8ball
//
//  Created by Abrish Sabri on 2/15/18.
//  Copyright © 2018 Abrish. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    let ballArray = ["ball1","ball2","ball3","ball4","ball5"]
    
    var randomBallNumber : Int = 0
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBAction func askButtonPressed(_ sender: Any)
    {
        newBallImage()
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        newBallImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func newBallImage()
    {
        randomBallNumber = Int(arc4random_uniform(5))
        ImageView.image = UIImage(named: ballArray[randomBallNumber] )
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?)
    {
        if motion == .motionShake
        {
            
            newBallImage()
            
            
        }
    }

}

