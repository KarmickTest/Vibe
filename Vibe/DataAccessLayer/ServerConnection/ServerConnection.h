//
//  ServerConnection.h
//  DarAlkitab
//
//  Created by Sayanta Bhowmick on 28/03/16.
//
//

#import <Foundation/Foundation.h>
typedef enum{
    social_login = 0,
    get_near_by_users,
    add_to_interestList,
    interestList

} Connection;

@protocol ServerConnectionDelegate
@optional
-(void)social_login:(id)result;
-(void)get_near_by_users:(id)result;
-(void)add_to_interestList:(id)result;
-(void)interestList:(id)result;
@end

@interface ServerConnection : NSObject<NSURLConnectionDelegate>{
    Connection mConnection;
}

@property(nonatomic,assign)id <ServerConnectionDelegate> delegate;
@property (retain, nonatomic)NSMutableData *receivedData;

+ (id)sharedManager;
-(void)social_login:(NSString *)fullname firstname:(NSString *)_firstname middlename:(NSString *)_middlename lastname:(NSString *)_lastname email:(NSString *)_email address:(NSString *)_address phone:(NSString *)_phone dob:(NSString *)_dob state:(NSString *)_state province:(NSString *)_province country:(NSString *)_country short_description:(NSString *)_short_description latitude:(NSString *)_latitude longitude:(NSString *)_longitude
            profile_pic:(NSString *)_profile_pic login_with:(NSString *)_login_with facebook_id:(NSString *)_facebook_id instagram_id:(NSString *)_instagram_id devicetoken:(NSString *)_devicetoken devicetype:(NSString *)_devicetype;
-(void)get_near_by_users:(NSString *)id email:(NSString *)user_email latitude:(NSString *)_latitude longitude:(NSString *)_longitude;
-(void)add_to_interestList:(NSString *)user_id user_email:(NSString *)_user_email interested_id:(NSString *)_interested_id interested_email:(NSString *)_interested_email;

-(void)interestList:(NSString *)emailid id:(NSString *)_id;
@end
//deviceId:”ba2407d9a6ff3e92”,
//deviceToken:”asdbjasd”,
//deviceType:”Android”,
//name:”test”,
//registrationType:”normal”,
//language:”en”,
//phoneNo:”15555215554”
