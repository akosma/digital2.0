//
//  SoundManager.m
//  Digital 2.0
//
//  Created by Adrian on 5/18/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "SoundManager.h"
#import "SoundEffect.h"
#import "SynthesizeSingleton.h"

@implementation SoundManager

SYNTHESIZE_SINGLETON_FOR_CLASS(SoundManager)

@synthesize sound11 = _sound11;
@synthesize sound12 = _sound12;
@synthesize sound13 = _sound13;
@synthesize sound21 = _sound21;
@synthesize sound22 = _sound22;
@synthesize sound23 = _sound23;
@synthesize sound31 = _sound31;
@synthesize sound32 = _sound32;
@synthesize sound33 = _sound33;

- (id)init
{
    if (self = [super init])
    {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path11 = [bundle pathForResource:@"Fluide_v2" ofType:@"wav"];
        NSString *path12 = [bundle pathForResource:@"login_v2" ofType:@"wav"];
        NSString *path13 = [bundle pathForResource:@"shop" ofType:@"wav"];
        NSString *path21 = [bundle pathForResource:@"projector_v2" ofType:@"wav"];
        NSString *path22 = [bundle pathForResource:@"clock2" ofType:@"wav"];
        NSString *path23 = [bundle pathForResource:@"realite augmentee" ofType:@"wav"];
//        NSString *path31 = nil;
        NSString *path32 = [bundle pathForResource:@"links" ofType:@"wav"];
        NSString *path33 = [bundle pathForResource:@"clap_v2" ofType:@"wav"];

        self.sound11 = [SoundEffect soundEffectWithContentsOfFile:path11];
        self.sound12 = [SoundEffect soundEffectWithContentsOfFile:path12];
        self.sound13 = [SoundEffect soundEffectWithContentsOfFile:path13];
        self.sound21 = [SoundEffect soundEffectWithContentsOfFile:path21];
        self.sound22 = [SoundEffect soundEffectWithContentsOfFile:path22];
        self.sound23 = [SoundEffect soundEffectWithContentsOfFile:path23];
        self.sound31 = nil;
        self.sound32 = [SoundEffect soundEffectWithContentsOfFile:path32];
        self.sound33 = [SoundEffect soundEffectWithContentsOfFile:path33];
    }
    return self;
}

- (void)dealloc
{
    self.sound11 = nil;
    self.sound12 = nil;
    self.sound13 = nil;
    self.sound21 = nil;
    self.sound22 = nil;
    self.sound23 = nil;
    self.sound31 = nil;
    self.sound32 = nil;
    self.sound33 = nil;
    [super dealloc];
}

@end
