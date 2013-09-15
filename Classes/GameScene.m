//
//  GameScene.m
//  Color Game
//
//  Created by Patrick Mc Gartoll on 9/25/10.
//  Copyright 2010 Drenguin. All rights reserved.
//
#include <stdlib.h>
#import "GameScene.h"
#import "SimpleAudioEngine.h"


CCLabel *color;
CCLabel *score;
NSString *colorName;
NSString *prevColorName;
int playerScore;
int prevPlayerScore;
CCSprite *bg;
CCSprite *redBg;
CCSprite *test;

@implementation GameScene

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
	
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
		CCMenuItemImage *blue = [CCMenuItemImage itemFromNormalImage:@"blueunselected.png" selectedImage:@"blueselected.png"
															  target:self
															selector:@selector(blueButtonClicked)];
		CCMenuItemImage *red = [CCMenuItemImage itemFromNormalImage:@"redunselected.png" selectedImage:@"redselected.png"
															 target:self
														   selector:@selector(redButtonClicked)];
		CCMenuItemImage *yellow = [CCMenuItemImage itemFromNormalImage:@"yellowunselected.png" selectedImage:@"yellowselected.png"
															  target:self
															selector:@selector(yellowButtonClicked)];
		CCMenuItemImage *green = [CCMenuItemImage itemFromNormalImage:@"greenunselected.png" selectedImage:@"greenselected.png"
															 target:self
														   selector:@selector(greenButtonClicked)];
		CCMenu *blueRedMenu = [CCMenu menuWithItems:blue,red,nil];
		CCMenu *yellowGreenMenu = [CCMenu menuWithItems:yellow,green,nil];
		[blueRedMenu alignItemsVerticallyWithPadding:90];
		[yellowGreenMenu alignItemsVerticallyWithPadding:90];
		blueRedMenu.position = ccp(100,160);
		yellowGreenMenu.position = ccp(380,160);
		
		bg = [CCSprite spriteWithFile:@"Whitebg.png"];
		bg.position = ccp(240,160);
		
		redBg = [CCSprite spriteWithFile:@"Redbg.png"];
		redBg.position = ccp(240,160);
		redBg.visible = FALSE;
		
		colorName = @"BLUE";
		prevColorName = @"RED";
		
		color = [CCLabel labelWithString:colorName fontName:@"Marker Felt" fontSize:45.0f];
		[color setColor:ccc3(0, 0, 0)];
		color.position = ccp(240,160);
		
		playerScore = 0;
		prevPlayerScore = -1;
		
		score = [CCLabel labelWithString:[NSString stringWithFormat:@"%d", playerScore] fontName:@"Marker Felt" fontSize:28.0f];
		[score setColor:ccc3(0, 0, 0)];
		score.position = ccp(455,295);
		
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"Cartoon String Break.caf"];
		
		[self schedule:@selector(callEveryFrame:)];
		[self addChild:redBg];
		[self addChild:bg z:-2];
		[self addChild:blueRedMenu];
		[self addChild:yellowGreenMenu];
		[self addChild:color];
		[self addChild:score];
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

-(void) callEveryFrame:(ccTime)dt{
	if(![colorName isEqualToString:prevColorName]) {
	   [color setString:colorName];
	}
	prevColorName = colorName;
	if(!(prevPlayerScore == playerScore)) {
		[score setString:[NSString stringWithFormat:@"%d", playerScore]];
	}
	prevPlayerScore = playerScore;
}

-(void) blueButtonClicked{
	if([colorName isEqualToString:@"BLUE"])
		[self setColorName];
	else{
		playerScore-=1;
		[self wrongAnswer];
	}
}
-(void) redButtonClicked{
	if([colorName isEqualToString:@"RED"])
		[self setColorName];
	else{
		playerScore-=1;
		[self wrongAnswer];
	}
}
-(void) yellowButtonClicked{
	if([colorName isEqualToString:@"YELLOW"])
		[self setColorName];
	else{
		playerScore-=1;
		[self wrongAnswer];
	}
}
-(void) greenButtonClicked{
	if([colorName isEqualToString:@"GREEN"])
		[self setColorName];
	else{
		playerScore-=1;
		[self wrongAnswer];
	}
}
-(void) setColorName {
	int r = arc4random() % 4;
	prevColorName = colorName;
	prevPlayerScore = playerScore;
	switch (r) {
		case 0:colorName = @"BLUE";
			break;
		case 1:colorName = @"RED";
			break;
		case 2:colorName = @"YELLOW";
			break;
		case 3:colorName = @"GREEN";
			break;
	}
	playerScore+=1;
	[self addParticles];
}

-(void)addParticles {
	CCParticleMeteor *emitter = [[CCParticleExplosion alloc] init];
	emitter.position = ccp(240,160);
	emitter.totalParticles = 100;
	emitter.life = 2.0f;
	[emitter setAutoRemoveOnFinish:TRUE];
	//[emitter setStartColor:ccc4FFromccc3B(ccc3(225, 0, 0))];
	[self addChild:emitter z:-1];
	[emitter release];
}

-(void)wrongAnswer {
	redBg.visible = TRUE;
	id a1 = [CCFadeIn actionWithDuration:.1];
	id a2 = [CCFadeOut actionWithDuration:.1];
	[[SimpleAudioEngine sharedEngine] playEffect:@"Cartoon String Break.caf"];
	[redBg runAction:[CCSequence actions:a1,a2,nil]];
}

- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
	/**if (CGRectContainsPoint([self rect], location)) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"Cartoon String Break.caf"];
        }**/
	
}
@end

