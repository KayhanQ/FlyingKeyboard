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
        self.backgroundColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0)

        keyboard.setScale(1)
        keyboard.position = CGPoint(x: CGRectGetMidX(self.frame) - keyboard.calculateAccumulatedFrame().width/2, y: 20)
        self.addChild(keyboard)
        
        self.physicsWorld.gravity = CGVectorMake(0, -14)
        
        let field = SKFieldNode.radialGravityField()
        field.position.x = keyboard.position.x + keyboard.calculateAccumulatedFrame().width/2
        field.position.y = keyboard.position.y + keyboard.calculateAccumulatedFrame().height - 50
        field.strength = -2.5
        field.falloff = 1
        
        self.addChild(field)
    }
    
    override func keyDown(theEvent: NSEvent) {

        let keyPressed = theEvent.charactersIgnoringModifiers
        
        print("\(keyPressed)")
        
        if keyboard.containsKey(keyPressed!) {
            /* Setup your scene here */
            let label = SKLabelNode(fontNamed:"Helvetica")
            label.text = keyPressed;
            label.fontSize = 42;
            let x = keyboard.getGlobalPosition(keyPressed!).x + randomBetween(-15, secondNum: 15)
            let y = keyboard.position.y + keyboard.calculateAccumulatedFrame().height + 4
            label.position = CGPoint(x: x, y: y)
            label.zRotation = randomBetween(-1, secondNum: 1)
            
            label.setScale(0.7)
            
            let physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: label.frame.width, height: label.frame.height))
            physicsBody.velocity = CGVector(dx: 0, dy: randomBetween(1200, secondNum: 1400))
            physicsBody.angularVelocity = randomBetween(-2, secondNum: 2)
            physicsBody.restitution = 0.5
            
            label.physicsBody = physicsBody
            
            let actionMove = SKAction.scaleTo(1, duration: 0.14)
            label.runAction(SKAction.sequence([actionMove]))

            self.addChild(label)
        }
    }
    
    func randomBetween(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    
}