//
//  SplashScreenViewController.m
//  Vibe
//
//  Created by SAYAN MAC MINI on 2/23/17.
//  Copyright © 2017 Karmickkarmick. All rights reserved.
//

#import "SplashScreenViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LoginViewController.h"
#import "Constant.h"
#import "HomeViewController.h"
static const float PLAYER_VOLUME = 0.0;
//static const float BUTTON_PADDING = 20.0f;
static const float BUTTON_CORNER_RADIUS = 8.0f;
static const float BUTTON_ANIM_DURATION = 3.0f;
static const float TITLE_ANIM_DURATION = 5.0f;
static const float LOGINBUTTON_ANIM_DURATION = 53.0f;
//static const float TITLE_FONT_SIZE = 72.0f;
@interface SplashScreenViewController ()
{
    AVPlayerLayer *playerLayer;
}
@property (nonatomic) UIImageView *titleLabel;
@property (nonatomic) UIButton *skipToLogin;
@property (nonatomic) AVPlayer *player;
@property (strong, nonatomic) IBOutlet UIView *playerView;

@end

@implementation SplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createVideoPlayer];
    [self createTitleLabel];
    [self createShowAnim];
    [self createLoginButton];
    [self createShowAnimforLoginButton];
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-145,self.view.frame.size.height-55, 130, 40)];
    btn.backgroundColor=[UIColor clearColor];
    [btn addTarget:self action:@selector(moviePlayDidEnd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
//    [self.view bringSubviewToFront:self.skipToLogin];
//    [self.skipToLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createShowAnim {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim.fromValue = @0.0f;
    anim.toValue = @1.0f;
    anim.duration = BUTTON_ANIM_DURATION;
    for (UIView *subview in self.view.subviews) {
        if ([subview isEqual:self.playerView] || [subview isEqual:self.titleLabel]) {
            continue;
        }
        [subview.layer addAnimation:anim forKey:@"alpha"];
    }
    CAKeyframeAnimation *keyAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    keyAnim.duration = TITLE_ANIM_DURATION;
    keyAnim.values = @[@0.0, @1.0, @0.0];
    keyAnim.keyTimes = @[@0.0, @0.35, @1.0];
    [self.titleLabel.layer addAnimation:keyAnim forKey:@"opacity"];
}
- (void)createShowAnimforLoginButton {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim.fromValue = @0.0f;
    anim.toValue = @1.0f;
//    anim.duration = BUTTON_ANIM_DURATION;
    for (UIView *subview in self.view.subviews) {
        if ([subview isEqual:self.playerView] || [subview isEqual:self.titleLabel]) {
            continue;
        }
        [subview.layer addAnimation:anim forKey:@"alpha"];
    }
    CAKeyframeAnimation *keyAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    keyAnim.duration = LOGINBUTTON_ANIM_DURATION;
    keyAnim.values = @[@0.0, @1.0, @0.0];
    keyAnim.keyTimes = @[@0.0, @0.35, @2.5];
    [self.skipToLogin.layer addAnimation:keyAnim forKey:@"opacity"];
}
- (void)createLoginButton {
    self.skipToLogin =[UIButton buttonWithType:UIButtonTypeSystem];
    self.skipToLogin.frame=CGRectMake(self.view.frame.size.width-145,self.view.frame.size.height-55, 130, 40);
    self.skipToLogin.alpha = 0.0f;
    [self.skipToLogin setTitle:@"Skip to Login" forState:UIControlStateNormal];
    [self.skipToLogin setTintColor:[UIColor whiteColor]];
    [self.skipToLogin setBackgroundColor:[UIColor clearColor]];
    [self.skipToLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.skipToLogin.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    self.skipToLogin.layer.borderWidth = 1.0f;
    self.skipToLogin.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.skipToLogin.clipsToBounds = YES;
    
    [self.skipToLogin addTarget:self action:@selector(moviePlayDidEnd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.skipToLogin];
    
}
- (void)createVideoPlayer {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"welcome_video" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    self.player.volume = PLAYER_VOLUME;
    
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.videoGravity = UIViewContentModeScaleToFill;
    playerLayer.frame = self.view.layer.bounds;
    [self.playerView.layer addSublayer:playerLayer];
    
    [self.player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

- (void)createTitleLabel {
    self.titleLabel = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 80, 80)];
    self.titleLabel.alpha = 0.0f;
    self.titleLabel.center = self.view.center;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.image=[UIImage imageNamed:@"vibeslogoimage"];
//    self.titleLabel.text = @"Vibes";
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    self.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.2];
//    self.titleLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
    [self.view addSubview:self.titleLabel];
}
#pragma mark - observer of player
- (void)moviePlayDidEnd{
    
//    AVPlayerItem *item = [notification object];
    [self.player pause];
    [playerLayer removeFromSuperlayer];
    self.player = nil;
//    [item seekToTime:kCMTimeZero];
//    [self.player play];
    if ([Utility isUserLoggedIn]) {
        
        HomeViewController *hvc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [UIView  beginAnimations: @"Showinfo"context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.75];
        [self.navigationController pushViewController: hvc animated:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
        [UIView commitAnimations];
    }
    else
    {
        LoginViewController *vcLoginViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [UIView  beginAnimations: @"Showinfo"context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.75];
        [self.navigationController pushViewController: vcLoginViewController animated:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
        [UIView commitAnimations];
    }

    
}
-(IBAction)loginClick:(id)sender
{
    //    AVPlayerItem *item = [notification object];
    [self.player pause];
    [playerLayer removeFromSuperlayer];
    self.player = nil;
    //    [item seekToTime:kCMTimeZero];
    //    [self.player play];
    if ([Utility isUserLoggedIn]) {
        
      HomeViewController *hvc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [UIView  beginAnimations: @"Showinfo"context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.75];
        [self.navigationController pushViewController: hvc animated:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
        [UIView commitAnimations];
    }
    else
    {
        LoginViewController *vcLoginViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [UIView  beginAnimations: @"Showinfo"context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.75];
        [self.navigationController pushViewController: vcLoginViewController animated:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
        [UIView commitAnimations];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
