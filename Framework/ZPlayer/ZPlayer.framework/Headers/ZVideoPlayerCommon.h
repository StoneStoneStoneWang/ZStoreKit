//
//  ZVideoPlayerCommon.h
//  DViewasd
//
//  Created by three stone 王 on 2019/8/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//


#define kMediaLength self.player.media.length
#define kWLRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kWLALPHARGB(r,g,b,al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]
#define kSCREEN_BOUNDS [[UIScreen mainScreen] bounds]

static const CGFloat WL_ProgressWidth = 3.0f;
static const CGFloat WL_VideoControlBarHeight = 40.0;
static const CGFloat WL_VideoControlSliderHeight = 10.0;
static const CGFloat WL_VideoControlAnimationTimeinterval = 0.3;
static const CGFloat WL_VideoControlTimeLabelFontSize = 10.0;
static const CGFloat WL_VideoControlBarAutoFadeOutTimeinterval = 4.0;
static const CGFloat WL_VideoControlCorrectValue = 3;
static const CGFloat WL_VideoControlAlertAlpha = 0.75;

