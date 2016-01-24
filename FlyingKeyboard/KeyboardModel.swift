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
    
    let offsets:Array<Float> = [0, 10, 12, 15]

    let letterWidth:Float = 32
    let letterSize:CGFloat = 35
    let scale:Float = 1
    
    override init() {
        super.init()
        createModel()
        drawKeyboard()
        
        let frame = self.calculateAccumulatedFrame()
        let floor = SKShapeNode(rectOfSize: CGSize(width: frame.width, height: 1))
        let body = SKPhysicsBody(rectangleOfSize: CGSize(width: frame.width, height: 1))
        body.affectedByGravity = false
        body.dynamic = false
        floor.physicsBody = body
        floor.position = CGPoint(x: self.position.x + frame.width/2, y: self.position.y + frame.height);
        self.addChild(floor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func containsKey(s:String) -> Bool {
        return layout[s] != nil
    }
    
    func createModel() {
        let strings = [["zxcvbnm,./","ZXCVBNM<>?"], ["asdfghjkl;'\"","ASDFGHJKL:"], ["qwertyuiop[]\\", "QWERTYUIOP{}|"],["`1234567890-=","~!#$%^&*()_+"]]
        var rowCount = 1
        var elemCount:Float = 0
        var index = 1
        for row in strings {
            for lineArr in row {
                let line = lineArr.characters.map { String($0) }
                print(line)
                
                for s in line {
                    let x:Float = (offsets[rowCount] + elemCount*letterWidth) * scale
                    let y:Float = (Float(rowCount)*letterWidth) * scale
                    layout[s] = CGPoint(x: CGFloat(x), y: CGFloat(y))
                    
                    elemCount++
                }
                elemCount = 0
            }

            index++
            if index % 2 == 0 {
                rowCount++
            }
        }
        print(layout)
    }
    
    func getPosition(s:String) -> CGPoint {
        return layout[s]!
    }
    
    func getGlobalPosition(s:String) -> CGPoint {
        let position = CGPoint(x: getPosition(s).x + self.position.x, y: getPosition(s).y + self.position.y)
        return position
    }
    
    
    func drawKeyboard() {
        self.removeAllChildren()
        
        for (key, position) in layout {
            let myLabel = SKLabelNode(fontNamed:"Helvetica")
            myLabel.text = key;
            myLabel.fontSize = letterSize;
            myLabel.position = position
            self.addChild(myLabel)
        }
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
 