//
//  LoginViewController.h
//  Vibe
//
//  Created by Admin on 15/02/17.
//  Copyright © 2017 Karmickkarmick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface LoginViewController : UIViewController
@property (strong,nonatomic)CLLocationManager *locationManager;
- (IBAction)btnTest:(id)sender;

@end
