//
//  HomeViewControler.swift
//  Monkey(davaleba25)
//
//  Created by anzori  on 2/27/23.
//  Copyright © 2023 anzori . All rights reserved.
//

import UIKit

class HomeViewControler: UIViewController{
  
   var topConstraint: NSLayoutConstraint!
    var scoreInt = 0
    @IBOutlet weak var cordinateLable: UILabel!
    @IBOutlet weak var Score: UILabel!
    @IBOutlet weak var mokeyImage: UIImageView!
    @IBOutlet var monkey: UIPanGestureRecognizer!
    @IBOutlet weak var bananas: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bananas.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = bananas.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
        topConstraint.isActive = true
        bananas.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.Score.text = "Score \(self.scoreInt)"
    }
    
    // monkey button
    @IBAction func monkey(_ sender: UIPanGestureRecognizer) {
        guard let  monkeyView = monkey.view else{
            return
        }
        let translation = monkey.translation(in: view)
        monkeyView.center.x += translation.x
        monkeyView.center.y += translation.y
        monkey.setTranslation(.zero, in: view)
  
    }
    // goback animation
    func animation(){
        self.topConstraint.constant = 100
        UIView.animate(withDuration: 0.5) {
        self.view.layoutIfNeeded()
        }
    }
    
    
@IBAction func banana(_ sender: UIButton) {
        if  mokeyImage.center == CGPoint(x: view.center.x, y: mokeyImage.center.y ) {
                UIView.animate(withDuration: 0.5, animations: {
            guard let  monkeyView = self.monkey.view else{
                 return
             }
            self.bananas.frame.origin.y += monkeyView.frame.height
            }) { (finished) in
                
                if finished {
                    let alert = UIAlertController(title: "Oh No", message: "You lost", preferredStyle: .alert)
                    let yesAction = UIAlertAction(title: "Try again", style: .default) { (action) in
                        self.bananas.frame.origin.y -= self.mokeyImage.frame.size.height
                        self.scoreInt = 0
                         self.Score.text = "Score \(self.scoreInt)"
                    }
                    alert.addAction(yesAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
            
            
       else{
            topConstraint.constant = view.bounds.height + 50
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            let alert = UIAlertController(title: "Happy", message: "You won", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Next", style: .default, handler: { _ in
                self.scoreInt = self.scoreInt + 1
                self.Score.text = "Score \(self.scoreInt)"
                self.animation()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
        
   }
    
}
    
    
    
    
    
    
    

