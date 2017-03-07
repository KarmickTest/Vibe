//
//  ServerConnection.m
//  DarAlkitab
//
//  Created by Sayanta Bhowmick on 28/03/16.
//
//

#import "ServerConnection.h"
#import "Constant.h"
#import "JSON.h"
#import "AppDelegate.h"
@implementation ServerConnection
#pragma mark Singleton Methods

+ (ServerConnection *)sharedManager {
    
    static ServerConnection *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedManager = [[self
                          alloc] init];
    });
    return sharedManager;
}

-(void)social_login:(NSString *)fullname firstname:(NSString *)_firstname middlename:(NSString *)_middlename lastname:(NSString *)_lastname email:(NSString *)_email address:(NSString *)_address phone:(NSString *)_phone dob:(NSString *)_dob state:(NSString *)_state province:(NSString *)_province country:(NSString *)_country short_description:(NSString *)_short_description latitude:(NSString *)_latitude longitude:(NSString *)_longitude
            profile_pic:(NSString *)_profile_pic login_with:(NSString *)_login_with facebook_id:(NSString *)_facebook_id instagram_id:(NSString *)_instagram_id devicetoken:(NSString *)_devicetoken devicetype:(NSString *)_devicetype
{
    mConnection = social_login;
    NSString *post = [NSString stringWithFormat:@"fullname=%@&firstname=%@&middlename=%@&lastname=%@&email=%@&address=%@&phone=%@&dob=%@&state=%@&province=%@&country=%@&short_description=%@&latitude=%@&longitude=%@&profile_pic=%@&login_with=%@&facebook_id=%@&instagram_id=%@&devicetoken=%@&devicetype=%@",fullname,_firstname,_middlename,_lastname,_email,_address,_phone,_state,_dob,_province,_country,_short_description,_latitude,_longitude,_profile_pic,_login_with,_facebook_id,_instagram_id,_devicetoken,_devicetype];//&userType=%@
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/social_login.php",BASEURL]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    if (connection) {
        _receivedData = [[NSMutableData alloc] init];
    }
}
-(void)get_near_by_users:(NSString *)id email:(NSString *)user_email latitude:(NSString *)_latitude longitude:(NSString *)_longitude
{
    mConnection = get_near_by_users;
    NSString *post = [NSString stringWithFormat:@"id=%@&email=%@&latitude=%@&longitude=%@",id,user_email,_latitude,_longitude];//&userType=%@
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/get_near_by_users.php",BASEURL]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    if (connection) {
        _receivedData = [[NSMutableData alloc] init];
    }
}
-(void)add_to_interestList:(NSString *)_user_id user_email:(NSString *)_user_email interested_id:(NSString *)_interested_id interested_email:(NSString *)_interested_email
{
    mConnection = add_to_interestList;
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_email=%@&interested_id=%@&interested_email=%@",_user_id,_user_email,_interested_id,_interested_email];//&userType=%@
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/add_to_interestList.php",BASEURL]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    if (connection) {
        _receivedData = [[NSMutableData alloc] init];
    }
}
-(void)interestList:(NSString *)email id:(NSString *)_id
{
    mConnection = interestList;
    NSString *post = [NSString stringWithFormat:@"email=%@&id=%@",email,_id];//&userType=%@
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/interestList.php",BASEURL]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    if (connection) {
        _receivedData = [[NSMutableData alloc] init];
    }
}
#pragma mark - Connection Delegates
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_receivedData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //NSLog(@"%@",error);
    NSLog(@"%@",error);
    switch (mConnection) {
        case social_login:
            [self.delegate social_login:error];
            break;
        case get_near_by_users:
            [self.delegate get_near_by_users:error];
            break;
        case add_to_interestList:
            [self.delegate add_to_interestList:error];
            break;
        case interestList:
            [self.delegate interestList:error];
            break;
        default:
            break;
    }
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *value=[[NSString alloc]initWithData:_receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",value);
    NSError *myError = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingMutableContainers error:&myError];
    switch (mConnection) {
        case social_login:
            [self.delegate social_login:jsonDict];
            break;
        case get_near_by_users:
            [self.delegate get_near_by_users:jsonDict];
            break;
        case add_to_interestList:
            [self.delegate add_to_interestList:jsonDict];
            break;
        case interestList:
            [self.delegate interestList:jsonDict];
            break;
        default:
            break;
    }
}


@end
