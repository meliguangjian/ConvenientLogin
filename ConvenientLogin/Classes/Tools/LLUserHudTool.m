//
//  LLUserHudTool.m
//  UserCenterDemo
//
//  Created by liguangjian on 17/3/3.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import "LLUserHudTool.h"

#import "MBProgressHUD.h"

@interface LLUserHudTool() <MBProgressHUDDelegate>
{
    MBProgressHUD *_hud;
}
@end

@implementation LLUserHudTool

+ (id)sharedInstance{
    __strong static LLUserHudTool *hud = nil;
    if (hud == nil) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            hud = [[self alloc] init];
        });
    }
    return hud;
}

- (void)showHudWithLoadingText:(NSString *)text view:(UIView *)view delay:(float)delay{
    _hud = [[MBProgressHUD alloc]initWithView:view];
    
    _hud.delegate = self;
    
    if (text) {
        //        _hud.labelText = text;
        _hud.detailsLabelText = text;
        _hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16.f];
    } else {
        //        _hud.labelText = nil;
        _hud.detailsLabelText = nil;
    }
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.dimBackground = NO;
    [view addSubview:_hud];
    [_hud show:YES];
    [_hud hide:YES afterDelay:delay];
}

- (void)showHudWithLoadingText:(NSString *)text view:(UIView *)view{
    _hud = [[MBProgressHUD alloc]initWithView:view];
    
    _hud.delegate = self;
    
    if (text) {
        //        _hud.labelText = text;
        _hud.detailsLabelText = text;
        _hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16.f];
    } else {
        //        _hud.labelText = nil;
        _hud.detailsLabelText = nil;
    }
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.dimBackground = NO;
    [view addSubview:_hud];
    [_hud show:YES];
}

// 显示hudg正在加载中，并提示文字
- (void)showHudWithLoadingText:(NSString *)text
{
    UIView *view = [self getCurrentView];
    if (_hud) {
        // 如果存在，就隐藏
        [_hud hide:NO];
    } else {
        // 如果不存在，实例化一个
        _hud = [[MBProgressHUD alloc]initWithView:view];
        
        _hud.delegate = self;
        NSLog(@"hud被创建了一次");
    }
    
    if (text) {
        //        _hud.labelText = text;
        _hud.detailsLabelText = text;
        _hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16.f];
    } else {
        //        _hud.labelText = nil;
        _hud.detailsLabelText = nil;
    }
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.dimBackground = NO;
    [view addSubview:_hud];
    [_hud show:YES];
}

// 显示秒钟的hud文字提示
- (void)showHudWithText:(NSString *)text delay:(float)delay{
    UIView *view = [self getCurrentView];
    if (_hud) {
        // 如果存在，就隐藏
        [_hud hide:NO];
    } else {
        // 如果不存在，实例化一个
        _hud = [[MBProgressHUD alloc]initWithView:view];
        _hud.delegate = self;
        NSLog(@"hud被创建了一次");
    }
    
    _hud.mode = MBProgressHUDModeText;
    //    _hud.labelText = text;
    _hud.detailsLabelText = text;
    _hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16.f];
    _hud.dimBackground = NO;
    [view addSubview:_hud];
    [_hud show:YES];
    [_hud hide:YES afterDelay:delay];
}

// 显示2秒钟的hud文字提示
- (void)showHudOneSecondWithText:(NSString *)text
{
    UIView *view = [self getCurrentView];
    if (_hud) {
        // 如果存在，就隐藏
        [_hud hide:NO];
    } else {
        // 如果不存在，实例化一个
        _hud = [[MBProgressHUD alloc]initWithView:view];
        _hud.delegate = self;
        NSLog(@"hud被创建了一次");
    }
    
    _hud.mode = MBProgressHUDModeText;
    //    _hud.labelText = text;
    _hud.detailsLabelText = text;
    _hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16.f];
    _hud.dimBackground = NO;
    [view addSubview:_hud];
    [_hud show:YES];
    [_hud hide:YES afterDelay:2.0f];
}

- (void)hideHud:(BOOL)animated delay:(float)delay{
    if (_hud != nil && ![_hud isHidden]) {
        //        NSLog(@"hideHudhideHudhideHudhideHud");
        [_hud hide:YES afterDelay:delay];
        //        [_hud hide:animated];
    }
}
// 隐藏移除hud,并nil
- (void)hideHud:(BOOL)animated
{
    
    if (_hud != nil && ![_hud isHidden]) {
        //        NSLog(@"hideHudhideHudhideHudhideHud");
        //        [_hud hide:YES afterDelay:2.0f];
        [_hud hide:animated];
    }
}


#pragma mark  MBProgressHUD代理方法
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    //    _hud.labelText = nil;
    _hud.detailsLabelText = nil;
    [_hud removeFromSuperview];
    //    _hud = nil;
}



- (UIView *)getCurrentView
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }
    else{
        result = window.rootViewController;
    }
    UIView *view;
    
    if (result) {
        view = result.view;
    }else{
        view = [[[UIApplication sharedApplication] delegate] window];
    }
    
    return view;
}

-(void)changeLabelText:(NSString *)text{
    if (_hud) {
        //        _hud.labelText = text;
        _hud.detailsLabelText = text;
        _hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16.f];
    }
}

@end
