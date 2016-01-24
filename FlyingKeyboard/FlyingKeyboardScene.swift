//
//  FlyingKeyboardScene.swift
//  FlyingKeyboard
//
//  Created by Kayhan Qaiser on 2016-01-23.
//  Copyright © 2016 Kayhan Qaiser. All rights reserved.
//

import Foundation
import SpriteKit

class FlyingKeyboardScene: SKScene {
    
    var keyboard = KeyboardModel()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = SKColor(red: 0.15, green:0.15, blue:0.3, alpha: 1.0)

        keyboard.position = CGPoint(x: 300, y: 80)
        self.addChild(keyboard)
        
        self.physicsWorld.gravity = CGVectorMake(0, -14)
        
        let field = SKFieldNode.radialGravityField()
        field.position.x = keyboard.position.x + keyboard.calculateAccumulatedFrame().width/2
        field.position.y = keyboard.position.y + keyboard.calculateAccumulatedFrame().height - 50
        field.strength = -2.5
        field.falloff = 1
        //field.region = SKRegion(radius: 30)
        
        self.addChild(field)
    }
    
    
    
    override func keyDown(theEvent: NSEvent) {

        let keyPressed = theEvent.charactersIgnoringModifiers
        
        print("\(keyPressed)")
        
        if keyboard.containsKey(keyPressed!) {
            /* Setup your scene here */
            let myLabel = SKLabelNode(fontNamed:"Helvetica")
            myLabel.text = keyPressed;
            myLabel.fontSize = 42;
            let x = keyboard.getGlobalPosition(keyPressed!).x + randomBetween(-15, secondNum: 15)
            let y = keyboard.position.y + keyboard.calculateAccumulatedFrame().height + 4
            myLabel.position = CGPoint(x: x, y: y)
            myLabel.zRotation = randomBetween(-1, secondNum: 1)
            
            myLabel.setScale(0.7)
            
            let physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: myLabel.frame.width, height: myLabel.frame.height))
            physicsBody.velocity = CGVector(dx: 0, dy: randomBetween(1200, secondNum: 1400))
            physicsBody.angularVelocity = randomBetween(-2, secondNum: 2)
            physicsBody.restitution = 0.5
            
            myLabel.physicsBody = physicsBody
            
            let actionMove = SKAction.scaleTo(1, duration: 0.14)
            myLabel.runAction(SKAction.sequence([actionMove]))

            self.addChild(myLabel)
        }
    }
    
    func randomBetween(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    
}