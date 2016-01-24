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

        keyboard.position = CGPoint(x: 100, y: 200)
        self.addChild(keyboard)
        
    }
    
    
    
    override func keyDown(theEvent: NSEvent) {

        let keyPressed = theEvent.charactersIgnoringModifiers
        
        print("\(keyPressed)")
        
        
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Helvetica")
        myLabel.text = keyPressed;
        myLabel.fontSize = 20;
        myLabel.position = keyboard.getGlobalPosition(keyPressed!)
        
        let actionMove = SKAction.moveToY(0, duration: 1)
        let actionMoveDone = SKAction.removeFromParent()
        myLabel.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        
        self.addChild(myLabel)
        
        
    }
    
}