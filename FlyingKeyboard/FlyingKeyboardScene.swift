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
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = SKColor(red: 0.15, green:0.15, blue:0.3, alpha: 1.0)

    }
    
    
    
    override func keyDown(theEvent: NSEvent) {

        let keyPressed = theEvent.charactersIgnoringModifiers
        
        print("\(keyPressed)")
        
        
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Helvetica")
        myLabel.text = keyPressed;
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:0);
        
        let actionMove = SKAction.moveToY(0, duration: 1)
        let actionMoveDone = SKAction.removeFromParent()
        myLabel.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        
        self.addChild(myLabel)
        
        
    }
    
}