//
//  D2SoundManager.h
//  Digital 2.0
//
//  Created by Adrian on 5/18/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SoundEffect;

@interface D2SoundManager : NSObject 

@property (nonatomic, retain) SoundEffect *sound11;
@property (nonatomic, retain) SoundEffect *sound12;
@property (nonatomic, retain) SoundEffect *sound13;
@property (nonatomic, retain) SoundEffect *sound21;
@property (nonatomic, retain) SoundEffect *sound22;
@property (nonatomic, retain) SoundEffect *sound23;
@property (nonatomic, retain) SoundEffect *sound31;
@property (nonatomic, retain) SoundEffect *sound32;
@property (nonatomic, retain) SoundEffect *sound33;

+ (D2SoundManager *)sharedD2SoundManager;

@end
