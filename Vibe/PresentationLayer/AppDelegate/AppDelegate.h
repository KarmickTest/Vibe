//
//  AppDelegate.h
//  Vibe
//
//  Created by Admin on 15/02/17.
//  Copyright © 2017 Karmickkarmick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, retain) NSString *devicetokenstring;;
- (void)saveContext;


@end

