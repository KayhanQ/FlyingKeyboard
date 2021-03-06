//
//  KeyboardModel.swift
//  FlyingKeyboard
//
//  Created by Kayhan Qaiser on 2016-01-23.
//  Copyright © 2016 Kayhan Qaiser. All rights reserved.
//

import Foundation
import SpriteKit

class KeyboardModel: SKNode {
    
    var layout:Dictionary<String, CGPoint> = Dictionary()
    
    
    //offsets = 2.75, 3.2, 4.15
    let offsets:Array<Float> = [4.6, 3.7, 2.8, 0].map{$0 * 20}
    let letterWidth:Float = 1.5*20
    let letterGap:Float = 0.3666666*20
    let topOffset:CGFloat = 50
    
    var keysNode:SKNode = SKNode()
    var highlightsNode:SKNode = SKNode()

    var lightsUp:Bool = true
    
    override init() {
        //visible = true
        super.init()
        
        self.addChild(keysNode)
        self.addChild(highlightsNode)
        
        createModel()
        drawKeyboard()
        
        let frame = self.calculateAccumulatedFrame()
        let floor = SKShapeNode(rectOfSize: CGSize(width: frame.width, height: 1))
        let body = SKPhysicsBody(rectangleOfSize: CGSize(width: frame.width, height: 1))
        body.affectedByGravity = false
        body.dynamic = false
        floor.alpha = 0
        floor.physicsBody = body
        floor.position = CGPoint(x: self.position.x + frame.width/2, y: self.position.y + frame.height + topOffset);
        self.addChild(floor)
        
        
        let border = SKShapeNode(rect: self.calculateAccumulatedFrame())
        border.alpha = 0
        self.addChild(border)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createModel() {
        let strings = [["zxcvbnm,./","ZXCVBNM<>?"], ["asdfghjkl;'","ASDFGHJKL:\""], ["qwertyuiop[]\\", "QWERTYUIOP{}|"],["`1234567890-=","~!@#$%^&*()_+"]]
        var rowCount = 0
        var elemCount:Float = 0
        var index = 0
        
        for row in strings {
            for lineArr in row {
                let line = lineArr.characters.map { String($0) }
                print(line)
                
                for s in line {
                    let x:Float = (offsets[rowCount] + elemCount*(letterWidth+letterGap))
                    let y:Float = (Float(rowCount)*(letterWidth+letterGap))
                    layout[s] = CGPoint(x: CGFloat(x), y: CGFloat(y))
                    
                    elemCount++
                }
                elemCount = 0
                if index % 2 == 1 {
                    rowCount++
                }
                index++
            }
        }
        print(layout)
    }
    
    func drawKeyboard() {
        removeNodesWithName("key")
        
        for (key, position) in layout {
            let label = SKLabelNode(fontNamed:"Helvetica")
            label.text = key
            label.name = "key"
            label.fontSize = CGFloat(letterWidth);
            label.position = position
            self.addChild(label)
        }
    }
    
    func removeNodesWithName(name: String) {
        for node in self.children {
            if node.name == name {
                node.removeFromParent()
            }
        }
    }
    
    var visible: Bool = true {
        didSet{
            if visible {
                drawKeyboard()
            }
            else {
                removeNodesWithName("key")
            }
        }
    }
    
    func keyPressed(s:String) {
        if lightsUp {
            let point:CGPoint = layout[s]!
            
            let circle = SKShapeNode(circleOfRadius: CGFloat(letterWidth)/2)
            circle.position = CGPoint(x: point.x, y: point.y+circle.frame.height/2)
            circle.fillColor = NSColor.whiteColor()
            circle.name = "highlight"
            self.addChild(circle)
        }
    }
    
    func keyDepressed(s:String) {
        if lightsUp {
            removeNodesWithName("highlight")
        }
    }
    
    func containsKey(s:String) -> Bool {
        return layout[s] != nil
    }
    
    func getPosition(s:String) -> CGPoint {
        return layout[s]!
    }
    
    func getGlobalPosition(s:String) -> CGPoint {
        let position = CGPoint(x: getPosition(s).x + self.position.x, y: getPosition(s).y + self.position.y)
        return position
    }
}

struct Coordinate<T: Equatable> {
    let x: T!
    let y: T!
    
    init(x: T, y: T) {
        self.x = x
        self.y = y
    }
}
 