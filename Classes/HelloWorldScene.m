//
//  HelloWorldLayer.m
//  Color Game
//
//  Created by Patrick Mc Gartoll on 9/24/10.
//  Copyright Drenguin 2010. All rights reserved.
//




// Import the interfaces
#import "HelloWorldScene.h"
#import "GameScene.h"
#import "SimpleAudioEngine.h"

// HelloWorld implementation
@implementation HelloWorld
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	
	
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		CCMenuItemImage *play = [CCMenuItemImage itemFromNormalImage:@"Playunselect.png" selectedImage:@"Playselect.png"
															  target:self
															selector:@selector(playButtonClicked)];
		CCMenu *menu = [CCMenu menuWithItems:play,nil];
		
		CCSprite *bg = [CCSprite spriteWithFile:@"Whitebg.png"];
		bg.position = ccp(230,160);
		
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"Cartoon String Break.caf"];
		[self addChild:bg];
		[self addChild:menu];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

-(void) playButtonClicked{
	[[CCDirector sharedDirector]replaceScene:[CCZoomFlipAngularTransition transitionWithDuration:1 scene: [GameScene node]]];
}
@end
