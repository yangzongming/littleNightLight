//
//  ViewController.m
//  ChatStory
//
//  Created by leo on 16/12/4.
//  Copyright © 2016年 Tang Yuan L inc. All rights reserved.
//

#import "ViewController.h"
#import "SetViewController.h"

@interface ViewController ()

@property (nonatomic,assign)NSInteger remainSeconds;
@property (nonatomic,assign)NSInteger msec;
@property (nonatomic,strong)IBOutlet UISwitch *lightSwitch;
@property (nonatomic,strong)IBOutlet UIWebView *_webView;
@end

@implementation ViewController
@synthesize remainSeconds;
@synthesize msec;
@synthesize lightSwitch;
@synthesize _webView;



- (void)viewDidLoad {
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                             target:self
                                           selector:@selector(loop)
                                           userInfo:nil
                                            repeats:YES];
    self.msec = 100;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetNightConfig) name:@"LightConfigChanged" object:nil];
    
    [self resetNightConfig];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.wselearning.com/Registerwordd/pro-1.aspx?winType=TYZZ1703LWD"]]];
    _webView.scalesPageToFit = YES;
    _webView.autoresizesSubviews = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)resetNightConfig{
    NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:kScreenColor];
    UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
    [self.view setBackgroundColor:color];
    
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:kTimeValue];
    self.remainSeconds = [number intValue]*100;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self updateSwitch];
    [super viewWillAppear:animated];
}

-(void)loop{
    BOOL isIdle = [[NSUserDefaults standardUserDefaults] boolForKey:kIsScreenIdle];
    
    if(isIdle){
        return;
    }
    
    if(remainSeconds == 0){
        //需要把屏幕亮度设置为0  并锁定屏幕
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    }else{
        remainSeconds--;
        NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:kTimeValue];
        int maxSeconds = number.intValue*100;
        
        //计算百分比 设定屏幕亮度
        CGFloat per = remainSeconds*1.0/maxSeconds;
        [[UIScreen mainScreen] setBrightness:per];
    }
}

-(IBAction)screenNeverClosedClick:(id)sender{
    BOOL isIdle = [[NSUserDefaults standardUserDefaults] boolForKey:kIsScreenIdle];
    [[NSUserDefaults standardUserDefaults] setBool:!isIdle forKey:kIsScreenIdle];
    [self updateSwitch];
}

-(void)updateSwitch{
    BOOL isIdle = [[NSUserDefaults standardUserDefaults] boolForKey:kIsScreenIdle];
    [lightSwitch setOn:isIdle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)setButtonClick{
    SetViewController *set = [[SetViewController alloc] initWithNibName:@"SetViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:set];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
