//
//  GameScene.h
//  Color Game
//
//  Created by Patrick Mc Gartoll on 9/25/10.
//  Copyright 2010 Drenguin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameScene : CCLayer {
	CCLabel *color;
	CCLabel *score;
	NSString *colorName;
	NSString *prevColorName;
	int playerScore;
	int prevPlayerScore;
	CCSprite *bg;
	CCSprite *redBg;
}

+(id)scene;
-(void) blueButtonClicked;
-(void) redButtonClicked;
-(void) yellowButtonClicked;
-(void) greenButtonClicked;
-(void) setColorName;
-(void) addParticles;
-(void) wrongAnswer;
@end
