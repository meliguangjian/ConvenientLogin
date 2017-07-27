//
//  ScanCode.m
//  ScanCode
//
//  Created by liguangjian on 16/9/10.
//  Copyright © 2016年 liguangjian. All rights reserved.
//

#import "LLUserScanCode.h"


#define cropW 240

@interface LLUserScanCode()
{
    AVCaptureSession *_captureSession;
    
    AVCaptureMetadataOutput *_output;
    
    AVCaptureConnection *_connection;
    
    AVCaptureDevice *_captureDevice;
    
    AVCaptureVideoPreviewLayer *_videoPreviewLayer;
    
    UIView *bgViwe;
    
    UIImageView *_scanLine;
    
    NSTimer *_timer;
    
    
    
    CGFloat _lineMoveStep;
    
    BOOL _findAResult;
    
    NSString * bundledddh;
}

@end


@implementation LLUserScanCode

-(id)init{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    //    NSString *bundledddh = [bundle pathForResource:@"ScanCode" ofType:@"bundle"];
    
    bundledddh = [bundle pathForResource: @ "ScanCode" ofType :@ "bundle"];
    
    return self;
}

- (void)setCamara:(UIView *)view ObjectsDelegate:(id<AVCaptureMetadataOutputObjectsDelegate>)objectsDelegate
{
    bgViwe = view;
    
    _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    
    // input
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:&error];
    if (error) {
        NSLog(@"%@",error.description);
        return;
    }
    
    // session
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:deviceInput];
    
    // output
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:_output];
    
    // 根据苹果的文档，这个队列必须是串行的
    [_output setMetadataObjectsDelegate:objectsDelegate queue:dispatch_get_main_queue()];
    /*
     // 也可以创建一个新线程
     dispatch_queue_t dispatchQueue;
     dispatchQueue = dispatch_queue_create("myQueue", NULL);
     [_output setMetadataObjectsDelegate:self queue:dispatchQueue];
     */
    
    if ([_output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
        if (self.bouth1D2D) { //同时需要支持条形码
            _output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
        } else { //只支持二维码
            _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        }
    }
    
    // videoPreviewLayer在屏幕上显示摄像头捕获到的图像
    _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    
    //    videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _videoPreviewLayer.videoGravity = AVLayerVideoGravityResize; // 需要调节焦距的设置
    
    _videoPreviewLayer.frame = view.layer.bounds;
    [view.layer addSublayer:_videoPreviewLayer];
    
    // connection（调节焦距使用）
    _connection = [_output connectionWithMediaType:AVMediaTypeVideo];
    
    // 开始扫描
    [_captureSession startRunning];
    
    [self setQRCodeFrameView];
    
}

- (void)setQRCodeFrameView
{
    // 扫描区域框
    CAShapeLayer *cropLayer = [[CAShapeLayer alloc] init];
    CGSize size = bgViwe.bounds.size;
    CGRect cropRect = CGRectMake((size.width - cropW) * 0.5, (size.height - cropW) * 0.5, cropW, cropW);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, bgViwe.bounds);
    
    cropLayer.fillRule = kCAFillRuleEvenOdd;
    cropLayer.path = path;
    cropLayer.fillColor = [[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor];
    
    [bgViwe.layer addSublayer:cropLayer];
    
    // 设置有效的扫描区域(为扫描框内的区域)
    _output.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
                                        
                                        cropRect.origin.x/size.width,
                                        
                                        cropRect.size.height/size.height,
                                        
                                        cropRect.size.width/size.width);
    
    // 边框
    UIImageView *borderView1 = [[UIImageView alloc] initWithFrame:CGRectMake( (size.width - cropW -10)*0.5, (size.height - cropW) * 0.5 -5, 30, 30)];
    
//    NSString *scan_1 = [bundledddh stringByAppendingPathComponent :@"scan_1"];
//    NSString *scan_2 = [bundledddh stringByAppendingPathComponent :@"scan_2"];
//    NSString *scan_3 = [bundledddh stringByAppendingPathComponent :@"scan_3"];
//    NSString *scan_4 = [bundledddh stringByAppendingPathComponent :@"scan_4"];
    
    NSString *scan_1 = @"scan_1";
    NSString *scan_2 = @"scan_2";
    NSString *scan_3 = @"scan_3";
    NSString *scan_4 = @"scan_4";
//    NSString *scan_net = [bundledddh stringByAppendingPathComponent :@"qrcode_scan_light_green"];
    NSString *scan_net = @"qrcode_scan_light_green";
    
    UIImage *borderImage = [UIImage imageNamed:scan_1];
    
    borderView1.image = borderImage;
    [bgViwe addSubview:borderView1];
    
    UIImageView *borderView2 = [[UIImageView alloc] initWithFrame:CGRectMake(size.width - (size.width - cropW -10)*0.5 - 30, (size.height - cropW) * 0.5 -5, 30, 30)];
    
    UIImage *borderImage2 = [UIImage imageNamed:scan_2];
    
    borderView2.image = borderImage2;
    [bgViwe addSubview:borderView2];
    
    UIImageView *borderView3 = [[UIImageView alloc] initWithFrame:CGRectMake((size.width - cropW -10.0)*0.5, (size.height - cropW) * 0.5 -5 + cropW - 17, 30, 30)];
    
    UIImage *borderImage3 = [UIImage imageNamed:scan_3];
    
    borderView3.image = borderImage3;
    [bgViwe addSubview:borderView3];
    
    UIImageView *borderView4 = [[UIImageView alloc] initWithFrame:CGRectMake(size.width - (size.width - cropW -10.0)*0.5- 30, (size.height - cropW) * 0.5 -5 + cropW - 17, 30, 30)];
    
    UIImage *borderImage4 = [UIImage imageNamed:scan_4];
    
    borderView4.image = borderImage4;
    [bgViwe addSubview:borderView4];
    
    // 扫描线
    _scanLine = [[UIImageView alloc] initWithFrame:CGRectMake((size.width - cropW) * 0.5, (size.height - cropW) * 0.5, cropW, 5)];
    _scanLine.image = [UIImage imageNamed:scan_net];
    [bgViwe addSubview:_scanLine];
    
//    NSLog(@"_scanLine:%f",borderView3.frame.origin.y + borderView3.frame.size.height + 10);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((size.width - cropW) * 0.5,borderView3.frame.origin.y + borderView3.frame.size.height + 10, cropW, 30)];
    label.text = @"将二维码放入扫描框内，即可自动扫描";
    [label setFont:[UIFont systemFontOfSize:12]];
    label.textAlignment = NSTextAlignmentCenter;
    [label setTextColor:[UIColor whiteColor]];
    [bgViwe addSubview:label];
    
    [self setTimer];
}

- (void)setTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(moveScanLine) userInfo:nil repeats:YES];
}

#pragma mark 扫描条动画
- (void)moveScanLine
{
//    NSLog(@"_scanLine:%f",_scanLine.transform.ty);
    
    if (_scanLine.transform.ty >= cropW) {
        _scanLine.transform = CGAffineTransformIdentity;
        _lineMoveStep = 0;
    } else {
        _lineMoveStep += 0.5;
        _scanLine.transform = CGAffineTransformMakeTranslation(0, _lineMoveStep);
    }
}

#pragma mark 设置焦距
- (void)setFocalLength:(CGFloat)lengthScale
{
    [UIView animateWithDuration:0.025 animations:^{
        [_videoPreviewLayer setAffineTransform:CGAffineTransformMakeScale(lengthScale+1, lengthScale+1)];
        _connection.videoScaleAndCropFactor = lengthScale+1;
    }];
    
}

#pragma mark 是否开灯
-(void)openLed:(BOOL)isOpen{
    if ([_captureDevice hasTorch]) {
        if (!isOpen) {
            [_captureDevice lockForConfiguration:nil];
            [_captureDevice setTorchMode: AVCaptureTorchModeOff];
            [_captureDevice unlockForConfiguration];
        }else{
            [_captureDevice lockForConfiguration:nil];
            [_captureDevice setTorchMode: AVCaptureTorchModeOn];
            [_captureDevice unlockForConfiguration];
        }
        
    }
}

-(void)stopScan{
    [_captureSession stopRunning];
    [_timer invalidate];
    
    _timer = nil;
}

-(void)startScan{
    [_captureSession startRunning];
    //    [_timer setFireDate:[NSDate date]];
}

#pragma mark 识别图片中得二维码
-(void)identifyCode:(UIImage*)image results:(ResultsBlock)results{
    [self stopScan];
    
    if(image){
        //1. 初始化扫描仪，设置设别类型和识别质量
        CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
        //2. 扫描获取的特征组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        //3. 获取扫描结果
        if (features.count>0) {
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            
            results(scannedResult);
        }else{
            results(@"");
        }
        
    }else {
        results(@"");
        
    }
}

@end
