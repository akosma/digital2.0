//
//  SoundManager.h
//  Digital 2.0
//
//  Created by Adrian on 5/18/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SoundEffect;

@interface SoundManager : NSObject 
{
@private
    SoundEffect *_sound11;
    SoundEffect *_sound12;
    SoundEffect *_sound13;
    SoundEffect *_sound21;
    SoundEffect *_sound22;
    SoundEffect *_sound23;
    SoundEffect *_sound31;
    SoundEffect *_sound32;
    SoundEffect *_sound33;
}

@property (nonatomic, retain) SoundEffect *sound11;
@property (nonatomic, retain) SoundEffect *sound12;
@property (nonatomic, retain) SoundEffect *sound13;
@property (nonatomic, retain) SoundEffect *sound21;
@property (nonatomic, retain) SoundEffect *sound22;
@property (nonatomic, retain) SoundEffect *sound23;
@property (nonatomic, retain) SoundEffect *sound31;
@property (nonatomic, retain) SoundEffect *sound32;
@property (nonatomic, retain) SoundEffect *sound33;

+ (SoundManager *)sharedSoundManager;

@end
