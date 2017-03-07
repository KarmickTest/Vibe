//
//  Constant.h
//  FleaApp
//
//  Copyright (c) 2015 karmick. All rights reserved.
//

#ifndef FleaApp_Constant_h
#define FleaApp_Constant_h

#import "Utility.h"
#import "DataValidation.h"
#import "UILabel+Border.h"
#import "UIView+Border.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>//#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "SpinnerView.h"
#import "ServerConnection.h"
#import "Base64.h"
#import "SDWebImageDownloader.h"
#import "UIImageView+WebCache.h"
#import "Utility.h"
#import "SpinnerView.h"
#define ALERT_TITLE @"Vibes"
#define BASEURL @"http://karmickdev.com/vibes/webservice"
// http://ec2-54-191-18-201.us-west-2.compute.amazonaws.com/
//http://karmickdev.com/squarecow/webservice
//http://www.karmickdev.com/boxhopp/
// http://karmickdev.com/squarecow/
//#define BASEURL @"http://192.168.1.24/boxhop"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define MAINSTORYBOARD [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define IPHONEWIDTH [[UIScreen mainScreen] bounds].size.width
#define IPHONEHEIGHT  [[UIScreen mainScreen] bounds].size.height

#define FULLHEIGHT [UIScreen mainScreen].bounds.size.height
#define FULLWIDTH  [UIScreen mainScreen].bounds.size.width

#define TWITTER_CONSUMER_KEY @"LhSmZwC1OMiPM9WLQqzlIIgKN"//@"HRrZPg09kVVtW5WFk4Nf9fzCO"
#define TWITTER_SECRET_KEY @"bNicFq1VUvaL3Ej5qcSYBD9KvPtGiARDBDW3UqBOhZlxsAmY6l"//b@"gdEuWoaAmZNzI5Tuk15EwsdtRtYjbfNeuETKAzOXDy88Cb0JJe"
#define DEGREES_IN_RADIANS(x) (M_PI * x / 180.0);

#define COLOR @"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"projectColor"];


#endif
typedef void(^KHJSondataBlock) (NSURLResponse *response, NSError *error,id resopncedata);
typedef void (^KHDownloadImage)(NSError *error, UIImage *image);
