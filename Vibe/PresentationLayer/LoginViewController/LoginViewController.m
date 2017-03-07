//
//  LoginViewController.m
//  Vibe
//
//  Created by Admin on 15/02/17.
//  Copyright © 2017 Karmickkarmick. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Constant.h"
#import "AppDelegate.h"
@interface LoginViewController ()<CLLocationManagerDelegate,ServerConnectionDelegate>
{
   
//     CLLocationManager *locationManager;
     NSDictionary *dict_Facebook;
    CLLocationDegrees user_latitude;
    CLLocationDegrees user_longitude;
    SpinnerView *mSpinnerView;
    AppDelegate *app;
    
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     mSpinnerView = [[SpinnerView alloc] init];
     app= (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *newLocation = [locations lastObject];
    CLLocation *oldLocation;
    if (locations.count >= 2) {
        oldLocation = [locations objectAtIndex:locations.count-1];
    } else {
        oldLocation = nil;
    }
    NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
     user_latitude= newLocation.coordinate.latitude;
    user_longitude = newLocation.coordinate.longitude;
    NSLog(@" \n%f \n%f",user_latitude,user_longitude);
    [self.locationManager stopUpdatingLocation];
//    NSLog(@"%@",manager);
}
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
//    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnTest:(id)sender {
    if ([Utility isNetworkAvailable]) {
        [self.view setUserInteractionEnabled:NO];
        [mSpinnerView setOnView:self.view withTextTitle:@"Loading..." withTextColour:[UIColor whiteColor] withBackgroundColour:[UIColor blackColor] animated:YES];
        
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        login.loginBehavior = FBSDKLoginBehaviorBrowser;
        
        [login logInWithReadPermissions:@[@"public_profile",@"user_hometown",@"user_birthday",@"email", @"user_friends"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
         {
             if (error)
             {
                 // Process error
                 [self.view setUserInteractionEnabled:YES];
                 [mSpinnerView hideFromView:self.view animated:YES];
                 [Utility showAlertWithTitle:ALERT_TITLE message:[NSString stringWithFormat:@"%@",error]];
             }
             else if (result.isCancelled)
             {
                 // Handle cancellations
                 [self.view setUserInteractionEnabled:YES];
                 [mSpinnerView hideFromView:self.view animated:YES];
                 //[Utility showAlertWithTitle:ALERT_TITLE message:@"Facebook Login Cancel."];
             }
             else
             {
                 if ([result.grantedPermissions containsObject:@"email"])
                 {
                     NSLog(@"result is:%@",result);
                     [self fetchUserInfo];
                 }
             }
         }];
    }
    else
    {
        [Utility showAlertWithTitle:ALERT_TITLE message:@"Please check internet connection of your Device"];
    }
//    HomeViewController *hvc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    
//    [self.navigationController pushViewController:hvc animated:YES];
//    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
//    login.loginBehavior = FBSDKLoginBehaviorBrowser;
//    
//    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
//     {
//         if (error)
//         {
//             // Process error
//             [self.view setUserInteractionEnabled:YES];
////             [mSpinnerView hideFromView:self.view animated:YES];
////             [Utility showAlertWithTitle:ALERT_TITLE message:[NSString stringWithFormat:@"%@",error]];
//         }
//         else if (result.isCancelled)
//         {
//             // Handle cancellations
//             [self.view setUserInteractionEnabled:YES];
////             [mSpinnerView hideFromView:self.view animated:YES];
//             //[Utility showAlertWithTitle:ALERT_TITLE message:@"Facebook Login Cancel."];
//         }
//         else
//         {
//             if ([result.grantedPermissions containsObject:@"email"])
//             {
//                 NSLog(@"result is:%@",result);
//                 [self fetchUserInfo];
//             }
//         }
//     }];
}


-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email,friends,birthday,gender,hometown"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 dict_Facebook = [[NSDictionary alloc] initWithDictionary:result];
                 NSLog(@"%@",dict_Facebook);

//                 strSocialEmail = [NSString stringWithFormat:@"%@",[result valueForKey:@"email"]];
//                 strLoginVia = @"facebook";
//                 app.isLogOut = NO;
                 if([app.devicetokenstring isEqualToString:@"(null)"] || app.devicetokenstring==nil){
                     app.devicetokenstring=@"87e5171529505a6fc73ec3620a9f5392f89252a13e1a5de41234123de76d6ddcb2b2b38";
                 }
//                 NSString *picData;
                 NSString *user_PPic;
                 if(![[[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"]isEqualToString:@""]){
                     NSData *imagedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"]]];
                    user_PPic = [[imagedata base64EncodedString] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
                 }
//                 NSString *user_PPic=[NSString stringWithFormat:@"%@",[[[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"] stringByReplacingOccurrencesOfString:@"&" withString:@"/"]];

                 ServerConnection *mServerConnection = [[ServerConnection alloc] init];
                 mServerConnection.delegate = self;
                 [mServerConnection social_login:[NSString stringWithFormat:@"%@",[result valueForKey:@"name"]] firstname:[NSString stringWithFormat:@"%@",[result valueForKey:@"first_name"]] middlename:@"" lastname:[NSString stringWithFormat:@"%@",[result valueForKey:@"last_name"]] email:[NSString stringWithFormat:@"%@",[result valueForKey:@"email"]]/*[NSString stringWithFormat:@"%@",[result valueForKey:@"email"]]*//*[NSString stringWithFormat:@"%@",[result valueForKey:@"email"]]*//*@"suv@g.com"*/ address:@"" phone:@"" dob:@"" state:@"" province:@"" country:@"" short_description:@"" latitude:[NSString stringWithFormat:@"%f",user_latitude] longitude:[NSString stringWithFormat:@"%f",user_longitude] profile_pic:user_PPic/*[[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"]*/ login_with:@"facebook" facebook_id:[NSString stringWithFormat:@"%@",[result valueForKey:@"id"]] instagram_id:@"" devicetoken:app.devicetokenstring devicetype:@"IOS"];
             }
//             [NSString stringWithFormat:@"%@",[result valueForKey:@"email"]]
             else
             {
                 NSLog(@"Error %@",error);
                 [self.view setUserInteractionEnabled:YES];
                 [mSpinnerView hideFromView:self.view animated:YES];
                 [Utility showAlertWithTitle:ALERT_TITLE message:[NSString stringWithFormat:@"%@",error]];
             }
         }];
    }

//    if ([FBSDKAccessToken currentAccessToken])
//    {
//        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
//        
//        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email,friends, locale, timezone"}]
//         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//             if (!error)
//             {
//                 dict_Facebook = [[NSDictionary alloc] initWithDictionary:result];
//                 
////                HomeViewController *hvc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
////                 [self.navigationController pushViewController:hvc animated:YES];
//                 
//                 NSLog(@"%@",dict_Facebook);
//                 
//             }
//         }];
//    }
}
-(void)social_login:(id)result
{
//    NSLog(@"%@",result);
    NSLog(@"%@",result);
    [self.view setUserInteractionEnabled:YES];
    [mSpinnerView hideFromView:self.view animated:YES];
    if([result isKindOfClass:[NSError class]]){
        [Utility showAlertWithTitle:ALERT_TITLE message:@"Networking problem.\n Try again."];
    }
    else if ([result isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = (NSDictionary *)result;
        if([[dict valueForKey:@"success"] integerValue]==1){
            NSLog(@"-----%@",[[dict valueForKey:@"list"]valueForKey:@"email"]);
            User *objUser = [User new];
            //objUser.user_ID = [[dict valueForKey:@"userDetails"] valueForKey:@"userId"];
//            objUser.user_ID =
            //            objUser.userImageUrl = [[dict valueForKey:@"userDetails"] valueForKey:@"userPrifileImage"];
            //            objUser.userAddress = [[dict valueForKey:@"userDetails"] valueForKey:@"userAddress"];
            //            objUser.userPhoneNo = [[dict valueForKey:@"userDetails"] valueForKey:@"userPhoneNo"];
            //            objUser.userDOB = [[dict valueForKey:@"userDetails"] valueForKey:@"userDOB"];
            //            objUser.userGender = [[dict valueForKey:@"userDetails"] valueForKey:@"userGender"];
            objUser.user_ID=[[dict valueForKey:@"list"]valueForKey:@"id"];
            objUser.userFirstName = [[dict valueForKey:@"list"]valueForKey:@"firstname"];
            objUser.userLastName = [[dict valueForKey:@"list"]valueForKey:@"lastname"];
            objUser.userEmailID = [[dict valueForKey:@"list"]valueForKey:@"email"];
            objUser.userPic=[[dict valueForKey:@"list"]valueForKey:@"profile_pic"];
            [Utility saveUserInfo:objUser];
            
            User *muser =[Utility getUserInfo];
            NSLog(@"%@",muser);
            
            [Utility setUserLoginEnable:YES];
        HomeViewController *hvc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
            
        [self.navigationController pushViewController:hvc animated:YES];
        }
        else{
            [Utility showAlertWithTitle:ALERT_TITLE message:[dict valueForKey:@"message"]];
        }
    }
    else{
        [Utility showAlertWithTitle:ALERT_TITLE message:@"Network Problem."];
    }
    
}
@end
