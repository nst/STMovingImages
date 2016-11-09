//
//  main.swift
//  MovieMaker
//
//  Created by nst on 05.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Foundation
import AppKit

func makeMovie() {
    
    guard let mm = STMovieMaker(
        path: "/tmp/test.mov",
        frameSize: CGSize(width:600, height:300),
        fps: 2) else {
            assertionFailure();
            return
    }
    
    for i in 1...12 {
        let s = String(format: "%02d", i)
        let path = "/System/Library/Frameworks/Quartz.framework/Versions/A/Frameworks/ImageKit.framework/Versions/A/Resources/earth_\(s).jpg"
        guard let image = NSImage(byReferencingFile: path) else { continue }
        _ = mm.append(image:image)
    }
    
    mm.write { (path) in
        //
    }
}

func makeGIF() {
    
    guard let gm = STGIFMaker(destinationPath: "/tmp/test.gif", loop: true) else {
        assertionFailure();
        return
    }
    
    for i in 1...12 {
        let s = String(format: "%02d", i)
        let path = "/System/Library/Frameworks/Quartz.framework/Versions/A/Frameworks/ImageKit.framework/Versions/A/Resources/earth_\(s).jpg"
        guard let image = NSImage(byReferencingFile: path) else { continue }
        
        gm.append(image: image, duration: 0.5)
    }
    
    _ = gm.write()
}

func makeMovieWithDrawings() {
    
    guard let mm = STMovieMaker(
        path: "/tmp/test2.mov",
        frameSize: CGSize(width:600, height:300),
        fps: 2) else {
            assertionFailure();
            return
    }
    
    for i in 1...12 {
        let s = String(format: "%02d", i)
        let path = "/System/Library/Frameworks/Quartz.framework/Versions/A/Frameworks/ImageKit.framework/Versions/A/Resources/earth_\(s).jpg"
        guard let image = NSImage(byReferencingFile: path) else { continue }
        _ = mm.appendImageFromDrawing({ (c) in
            
            // draw image
            let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            image.draw(in: rect)
            
            // draw string frame
            let STRING_RECT_ORIGIN_X : CGFloat = rect.size.width - 60
            let STRING_RECT_ORIGIN_Y : CGFloat = 30
            let STRING_RECT_WIDTH : CGFloat = 40
            let STRING_RECT_HEIGHT : CGFloat = 30
            let stringRect : CGRect = CGRect(x: STRING_RECT_ORIGIN_X, y: STRING_RECT_ORIGIN_Y, width: STRING_RECT_WIDTH, height: STRING_RECT_HEIGHT);
            
            NSColor.white.setFill()
            NSColor.black.setStroke()
            NSRectFill(stringRect)
            NSBezierPath.stroke(stringRect)
            
            // draw string
            let font = NSFont(name:"Courier", size:24)!
            let attributes : [String:AnyObject] = [NSFontAttributeName:font, NSForegroundColorAttributeName:NSColor.blue]
            
            let s = NSAttributedString(string: s, attributes: attributes)
            s.draw(at: CGPoint(x: STRING_RECT_ORIGIN_X + 6, y: STRING_RECT_ORIGIN_Y + 2))
        })
    }
    
    mm.write { (path) in
        //
    }
}

makeMovie()
makeGIF()
makeMovieWithDrawings()

RunLoop.main.run()
