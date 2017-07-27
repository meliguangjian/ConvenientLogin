//
//  ScanCode.h
//  ScanCode
//
//  Created by liguangjian on 16/9/10.
//  Copyright © 2016年 liguangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

typedef void(^ResultsBlock) (NSString *resultsStr);

@interface LLUserScanCode : UIView

- (void)setCamara:(UIView *)view ObjectsDelegate:(id<AVCaptureMetadataOutputObjectsDelegate>)objectsDelegate;

- (void)setFocalLength:(CGFloat)lengthScale;        //0 ———— 1

-(void)openLed:(BOOL)isOpen;

-(void)stopScan;

-(void)startScan;

-(void)identifyCode:(UIImage*)image results:(ResultsBlock)results;

@property (assign,nonatomic)BOOL bouth1D2D;

@end
