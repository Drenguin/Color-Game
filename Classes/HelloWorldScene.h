//
//  HelloWorldLayer.h
//  Color Game
//
//  Created by Patrick Mc Gartoll on 9/24/10.
//  Copyright Drenguin 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"


// HelloWorld Layer
@interface HelloWorld : CCLayer
{
	
}


// returns a Scene that contains the HelloWorld as the only child
+(id) scene;
-(void) playButtonClicked;
@end
