//
//  ViewController.swift
//  STMovingImages_iOS
//
//  Created by Nicolas Seriot on 09.11.16.
//  Copyright © 2016 ch.seriot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    func makeGIF() {
        
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        guard let path = documentsPath.appendingPathComponent("test.gif")?.path else { assertionFailure(); return }
        
        guard let gm = STGIFMaker(destinationPath: path, loop: true) else {
            assertionFailure();
            return
        }
        
        for i in 1...12 {
            let s = String(format: "%02d", i)
            guard let image = UIImage(named:"earth_\(s).jpg") else { continue }
            
            gm.append(image: image, duration: 0.5)
        }
        
        _ = gm.write()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        makeGIF()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

