//
//  TWTMenuViewController.m
//  TWTSideMenuViewController-Sample
//
//  Created by Josh Johnson on 8/14/13.
//  Copyright (c) 2013 Two Toasters. All rights reserved.
//

#import "TWTMenuViewController.h"
#import "TWTSideMenuViewController.h"
#import "UserProfileViewController.h"
#import "SettingsViewController.h"
#import "AwaitingBidsViewController.h"
#import "DashboardViewController.h"
#import "AppDelegate.h"
#import "Constant.h"

@interface TWTMenuViewController (){
    AppDelegate *app;
    User *mUser;
    UIButton *btnDashboard;
    UIButton *btnBids;
    UIView *vwMenuList;
    UIButton *btnHome;
    
}

@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation TWTMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self releaseMemory];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mUser = [User new];
    mUser = [DatabaseQuery selectUserDetails:[NSString stringWithFormat:@"%@",[DatabaseQuery getUserID]]];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"Sliderbg-img"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    closeButton.frame = CGRectMake(10.0f, 30.0f, 20.0f,20.0f);
    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"cross-mark.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    NSLog(@"%f",FULLHEIGHT/2-160);
    
    vwMenuList = [[UIView alloc] initWithFrame:CGRectMake(0, FULLHEIGHT/2-160, 250, 320)];//self.view.frame.size.height/2-135
    vwMenuList.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:vwMenuList];
    
    btnHome = [UIButton buttonWithType:UIButtonTypeSystem];
    btnHome.frame = CGRectMake(40.0f,0, 200.0f, 40.0f);
    [btnHome setTitle:@"Home" forState:UIControlStateNormal];
    btnHome.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnHome.titleLabel.font = [UIFont fontWithName:@"GalanoClassic-MediumAlt" size:18.0f];
    [btnHome setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnHome addTarget:self action:@selector(homePressed) forControlEvents:UIControlEventTouchUpInside];
    [vwMenuList addSubview:btnHome];
    
    btnDashboard = [UIButton buttonWithType:UIButtonTypeSystem];
    btnDashboard.frame = CGRectMake(btnHome.frame.origin.x,btnHome.frame.origin.y+btnHome.frame.size.height+6, 200.0f, 40.0f);
    [btnDashboard setTitle:@"Dashboard" forState:UIControlStateNormal];
    btnDashboard.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnDashboard.titleLabel.font = [UIFont fontWithName:@"GalanoClassic-MediumAlt" size:18.0f];
    [btnDashboard setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDashboard addTarget:self action:@selector(dashboardPressed) forControlEvents:UIControlEventTouchUpInside];
    
    btnBids = [UIButton buttonWithType:UIButtonTypeSystem];
    if([mUser.userType isEqualToString:@"company"]){
        [vwMenuList addSubview:btnDashboard];
        btnBids.frame = CGRectMake(btnDashboard.frame.origin.x,btnDashboard.frame.origin.y+btnDashboard.frame.size.height+6, 200.0f, 40.0f);
    }
    else{
        btnBids.frame = CGRectMake(btnHome.frame.origin.x,btnHome.frame.origin.y+btnHome.frame.size.height+6, 200.0f, 40.0f);
    }
    [btnBids setTitle:@"Moving Price Quotes" forState:UIControlStateNormal];
    btnBids.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnBids.titleLabel.font = [UIFont fontWithName:@"GalanoClassic-MediumAlt" size:18.0f];
    [btnBids setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnBids addTarget:self action:@selector(Bidspressed) forControlEvents:UIControlEventTouchUpInside];
    [vwMenuList addSubview:btnBids];
    
    
    UIButton *btnVideomymove = [UIButton buttonWithType:UIButtonTypeSystem];
    btnVideomymove.frame = CGRectMake(btnBids.frame.origin.x,btnBids.frame.origin.y+btnBids.frame.size.height+6, 200.0f, 40.0f);
    [btnVideomymove setTitle:@"Record My Move" forState:UIControlStateNormal];
    btnVideomymove.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnVideomymove.titleLabel.font = [UIFont fontWithName:@"GalanoClassic-MediumAlt" size:18.0f];
    [btnVideomymove setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnVideomymove addTarget:self action:@selector(Videomymovepressed) forControlEvents:UIControlEventTouchUpInside];
    [vwMenuList addSubview:btnVideomymove];
    
    
    UIButton *btnSendmymove = [UIButton buttonWithType:UIButtonTypeSystem];
    btnSendmymove.frame = CGRectMake(btnVideomymove.frame.origin.x,btnVideomymove.frame.origin.y+btnVideomymove.frame.size.height+6, 200.0f, 40.0f);
    [btnSendmymove setTitle:@"Send My Move" forState:UIControlStateNormal];
    btnSendmymove.titleLabel.font = [UIFont fontWithName:@"GalanoClassic-MediumAlt" size:18.0f];
    btnSendmymove.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnSendmymove setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSendmymove addTarget:self action:@selector(Sendmymove) forControlEvents:UIControlEventTouchUpInside];
    [vwMenuList addSubview:btnSendmymove];
    
    
    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeSystem];
    btnSetting.frame = CGRectMake(btnSendmymove.frame.origin.x,btnSendmymove.frame.origin.y+btnSendmymove.frame.size.height+6, 200.0f, 40.0f);
    [btnSetting setTitle:@"Settings" forState:UIControlStateNormal];
    btnSetting.titleLabel.font = [UIFont fontWithName:@"GalanoClassic-MediumAlt" size:18.0f];
    btnSetting.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnSetting setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSetting addTarget:self action:@selector(Settingspressed) forControlEvents:UIControlEventTouchUpInside];
    [vwMenuList addSubview:btnSetting];
    
    
    UIButton *btnLogout = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLogout.frame = CGRectMake(btnSetting.frame.origin.x,btnSetting.frame.origin.y+btnSetting.frame.size.height+6, 200.0f, 40.0f);
    [btnLogout setTitle:@"Logout" forState:UIControlStateNormal];
    btnLogout.titleLabel.font = [UIFont fontWithName:@"GalanoClassic-MediumAlt" size:18.0f];
    btnLogout.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnLogout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLogout addTarget:self action:@selector(LogoutPressed) forControlEvents:UIControlEventTouchUpInside];
    [vwMenuList addSubview:btnLogout];
}

-(void)releaseMemory{
    [vwMenuList removeFromSuperview];
    for (UIView *view in [vwMenuList subviews]) {
        if([view isKindOfClass:[UIButton class]]){
            [view removeFromSuperview];
            NSLog(@"BUTTON RELEASE");
        }
    }
}

- (void)closeButtonPressed
{
    [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
}

- (void)changeButtonPressed

{
    
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[UserProfileViewController new]];
    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    
}

- (void)Allprojectspressed

{
    //    UIStoryboard*story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"Allprojects"]];
    //    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    
}

-(void)homePressed{
    //UserProfileViewController
    app.isLogOut = NO;
    app.isHomeMenuPressed=YES;
    app.str_storyboardId=@"home";
    UIStoryboard*story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"UserProfileViewController"]];
    controller.navigationBarHidden = YES;
    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
}

-(void)dashboardPressed{
    //UserProfileViewController
    app.str_storyboardId=@"dash";
    UIStoryboard*story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"DashboardViewController"]];
    controller.navigationBarHidden = YES;
    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
}

- (void)Settingspressed
{
    app.str_storyboardId=@"Settings";
    UIStoryboard*story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"SettingsViewController"]];
    controller.navigationBarHidden = YES;
    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    
}

- (void)Videomymovepressed

{
    /*UIStoryboard*story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"videotab"]];
     [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];*/
    //Awatingbids
    
    app.isVideoMyMove = YES;
    app.isAttachedVideo = NO;
    UIStoryboard*story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"UserProfileViewController"]];
    controller.navigationBarHidden = YES;
    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
}

- (void)Bidspressed

{
    app.str_storyboardId=@"bid";
    UIStoryboard*story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"AwaitingBidsViewController"]];
    controller.navigationBarHidden = YES;
    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
}

-(void)Sendmymove
{
    //    UIStoryboard*story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"SendMyMoveViewController"]];
    //    controller.navigationBarHidden = YES;
    //
    //   [self setPresentationStyleForSelfController:controller presentingController:self.sideMenuViewController];
    //
    //    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    app.isMenupressed=YES;
    if ([app.str_storyboardId isEqualToString:@"home"]) {
        [self homePressed];
    }
    else if ([app.str_storyboardId isEqualToString:@"dash"])
    {
        [self dashboardPressed];
    }
    else if ([app.str_storyboardId isEqualToString:@"bid"])
    {
        [self Bidspressed];
    }
    else if([app.str_storyboardId isEqualToString:@"Settings"])
    {
        [self Settingspressed];
    }
    
    //    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    //
    //    if (numberOfViewControllers < 2)
    //        [self.navigationController.viewControllers objectAtIndex:numberOfViewControllers];
    ////        NSLog(@"DO NOTHING");
    //    else
    //     [self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2];
    
    // [self.navigationController popViewControllerAnimated:YES];
}
- (void)setPresentationStyleForSelfController:(UIViewController *)selfController presentingController:(UIViewController *)presentingController
{
    if ([NSProcessInfo instancesRespondToSelector:@selector(isOperatingSystemAtLeastVersion:)])
    {
        //iOS 8.0 and above
        presentingController.providesPresentationContextTransitionStyle = YES;
        presentingController.definesPresentationContext = YES;
        
        [presentingController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    }
    else
    {
        [selfController setModalPresentationStyle:UIModalPresentationCurrentContext];
        [selfController.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    }
}

-(void)LogoutPressed

{
    app.isLogOut = YES;
    UIStoryboard*story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"UserProfileViewController"]];
    controller.navigationBarHidden = YES;
    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
