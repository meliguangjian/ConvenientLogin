//
//  LLUserHudTool.h
//  UserCenterDemo
//
//  Created by liguangjian on 17/3/3.
//  Copyright © 2017年 liguangjian. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LLUserHudTool : NSObject

+ (id)sharedInstance;

// 显示1秒钟的hud文字提示
- (void)showHudOneSecondWithText:(NSString *)text;

// 显示hud正在加载中，并提示文字
- (void)showHudWithLoadingText:(NSString *)text;

- (void)hideHud:(BOOL)animated delay:(float)delay;

// 隐藏移除hud,并nil
- (void)hideHud:(BOOL)animated;

// 显示秒钟的hud文字提示
- (void)showHudWithText:(NSString *)text delay:(float)delay;

-(void)changeLabelText:(NSString *)text;

- (void)showHudWithLoadingText:(NSString *)text view:(UIView *)view;

- (void)showHudWithLoadingText:(NSString *)text view:(UIView *)view delay:(float)delay;

@end
