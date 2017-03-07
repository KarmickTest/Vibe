//
//  HomeViewController.m
//  Vibe
//
//  Created by Admin on 15/02/17.
//  Copyright © 2017 Karmickkarmick. All rights reserved.
//

#import "HomeViewController.h"
#import "ProfileDetailsViewController.h"
#import "Constant.h"
#import "NearbyUserUITableViewCell.h"
#import "PersonalInfoTableViewCell.h"

@interface HomeViewController ()<ServerConnectionDelegate>
{
    CGRect frameimg;
    CGRect frameimg1;
    CGRect frameimg2;
    CGRect frameimg3;
    CGRect frameimg4;
    CGRect frameimg5;
    CGRect frameimg6;
    SpinnerView *mSpinnerView;
    NSMutableArray *arr_nearbyUsers;
    NSInteger tappedImage;
    NSArray *imageNames;
    NSMutableArray *images;
    User *mUser;
    BOOL apiCalled;
    BOOL api_InterestList;
}
@property (strong, nonatomic) IBOutlet UIImageView *imgview1;
@property (strong, nonatomic) IBOutlet UIImageView *img_beaker;
@property (strong, nonatomic) IBOutlet UIView *vw_below;
@property (strong, nonatomic) IBOutlet UIImageView *img_UserOwn;
@property (strong, nonatomic) IBOutlet UIImageView *imgview2;
@property (strong, nonatomic) IBOutlet UIImageView *imgview3;
@property (strong, nonatomic) IBOutlet UIImageView *imgview4;
@property (strong, nonatomic) IBOutlet UIImageView *imgview5;
@property (strong, nonatomic) IBOutlet UIImageView *imgview6;
@property (strong, nonatomic) IBOutlet UITableView *tblvw_userDetails;
@property (strong, nonatomic) IBOutlet UIImageView *img_detailsHeader;
@property (strong, nonatomic) IBOutlet UIView *vw_userDetails;

@end

@implementation HomeViewController
//karmicksol201@gmail.com
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    apiCalled=NO;
    mUser = [User new];
    mUser = [Utility getUserInfo];
    NSLog(@"%@",mUser.userEmailID);
    
    imageNames = @[@"sm2.png", @"sm3.png", @"sm4.png"];
    
     images= [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    NSData *imageData =[[NSData alloc] initWithBase64EncodedString:mUser.userPic options:0];  //[NSData dataWithContentsOfURL:url];
    UIImage *img1 = [UIImage imageWithData:imageData];
    _img_UserOwn.image=img1;
    
    tappedImage=0;
    _tblvw_userDetails.layer.cornerRadius=8.0;
    
    _imgview1.userInteractionEnabled = YES;
    _imgview2.userInteractionEnabled=YES;
     _imgview3.userInteractionEnabled=YES;
     _imgview4.userInteractionEnabled=YES;
     _imgview5.userInteractionEnabled=YES;
     _imgview6.userInteractionEnabled=YES;
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(labelDragged:)];
    UIPanGestureRecognizer *gesture1 = [[UIPanGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(labelDragged:)];
    UIPanGestureRecognizer *gesture2 = [[UIPanGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(labelDragged:)];
    UIPanGestureRecognizer *gesture3 = [[UIPanGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(labelDragged:)];
    UIPanGestureRecognizer *gesture4 = [[UIPanGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(labelDragged:)];
    UIPanGestureRecognizer *gesture5 = [[UIPanGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(labelDragged:)];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
     UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
     UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
     UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
     UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
     UITapGestureRecognizer *singleTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
     UITapGestureRecognizer *singleTap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    [self.view addGestureRecognizer:singleTap6];
    self.view.tag=1024;
    
    singleTap.numberOfTapsRequired = 1;
    singleTap1.numberOfTapsRequired = 1;
    singleTap2.numberOfTapsRequired = 1;
    singleTap3.numberOfTapsRequired = 1;
    singleTap4.numberOfTapsRequired = 1;
    singleTap5.numberOfTapsRequired = 1;
    
    [_imgview1 addGestureRecognizer:singleTap];
    [_imgview2 addGestureRecognizer:singleTap1];
    [_imgview3 addGestureRecognizer:singleTap2];
    [_imgview4 addGestureRecognizer:singleTap3];
    [_imgview5 addGestureRecognizer:singleTap4];
    [_imgview6 addGestureRecognizer:singleTap5];
   
    
    frameimg=_imgview1.frame;
    frameimg1=_imgview2.frame;
    frameimg2=_imgview3.frame;
    frameimg3=_imgview4.frame;
    frameimg4=_imgview5.frame;
    frameimg5=_imgview6.frame;
    
    [_imgview1 addGestureRecognizer:gesture];
    [_imgview2 addGestureRecognizer:gesture1];
    [_imgview3 addGestureRecognizer:gesture2];
    [_imgview4 addGestureRecognizer:gesture3];
    [_imgview5 addGestureRecognizer:gesture4];
    [_imgview6 addGestureRecognizer:gesture5];
    
    
    _imgview1.layer.cornerRadius=15.0;
    _imgview1.clipsToBounds=YES;
    _imgview1.layer.borderWidth=1.1;
    _imgview1.layer.masksToBounds = YES;
    _imgview1.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    _imgview2.layer.cornerRadius=15.0;
    _imgview2.clipsToBounds=YES;
    _imgview2.layer.borderWidth=1.1;
    _imgview2.layer.masksToBounds = YES;
    _imgview2.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    _imgview3.layer.cornerRadius=15.0;
    _imgview3.clipsToBounds=YES;
    _imgview3.layer.borderWidth=1.1;
    _imgview3.layer.masksToBounds = YES;
    _imgview3.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    _imgview4.layer.cornerRadius=15.0;
    _imgview4.clipsToBounds=YES;
    _imgview4.layer.borderWidth=1.1;
    _imgview4.layer.masksToBounds = YES;
    _imgview4.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    _imgview5.layer.cornerRadius=15.0;
    _imgview5.clipsToBounds=YES;
    _imgview5.layer.borderWidth=1.1;
    _imgview5.layer.masksToBounds = YES;
    _imgview5.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    _imgview6.layer.cornerRadius=15.0;
    _imgview6.clipsToBounds=YES;
    _imgview6.layer.borderWidth=1.1;
    _imgview6.layer.masksToBounds = YES;
    _imgview6.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    _img_UserOwn.layer.cornerRadius=15.0;
    _img_UserOwn.clipsToBounds=YES;
    _img_UserOwn.layer.borderWidth=1.1;
    _img_UserOwn.layer.masksToBounds = YES;
    _img_UserOwn.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    mSpinnerView=[[SpinnerView alloc]init];
    [self.view setUserInteractionEnabled:NO];
    [mSpinnerView setOnView:self.view withTextTitle:@"Loading..." withTextColour:[UIColor whiteColor] withBackgroundColour:[UIColor blackColor] animated:YES];
    
    
    ServerConnection *mServerConnection = [[ServerConnection alloc] init];
    mServerConnection.delegate = self;
    [mServerConnection get_near_by_users:@"" email:mUser.userEmailID latitude:@"" longitude:@""];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    apiCalled=NO;
    if (arr_nearbyUsers.count>0) {
//        NSURL *url = [NSURL URLWithString:[arr_nearbyUsers objectAtIndex:0]];
//        NSData *imageData = [NSData dataWithContentsOfURL:url];
//        UIImage *ret = [UIImage imageWithData:imageData];
//        _imgview1.image=
        if (arr_nearbyUsers.count==1) {
            //                NSURL *url = [NSURL URLWithString:[[arr_nearbyUsers objectAtIndex:i]valueForKey:@"profile_pic"]];
            NSData *imageData =[[NSData alloc] initWithBase64EncodedString:[[arr_nearbyUsers objectAtIndex:0]valueForKey:@"profile_pic"] options:0];  //[NSData dataWithContentsOfURL:url];
            UIImage *img1 = [UIImage imageWithData:imageData];
            _imgview1.image=img1;
        }
        else if (arr_nearbyUsers.count==2)
        {
            for (int i=0; i<arr_nearbyUsers.count; i++) {
                //                NSURL *url = [NSURL URLWithString:[[arr_nearbyUsers objectAtIndex:i]valueForKey:@"profile_pic"]];
                NSData *imageData =[[NSData alloc] initWithBase64EncodedString:[[arr_nearbyUsers objectAtIndex:i]valueForKey:@"profile_pic"] options:0];  //[NSData dataWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:imageData];
                if (i==0) {
                    _imgview1.image=img;
                }
                else if (i==1)
                {
                    _imgview2.image=img;
                }
            }
        }
        else if (arr_nearbyUsers.count==3)
        {
            for (int i=0; i<arr_nearbyUsers.count; i++) {
                //                NSURL *url = [NSURL URLWithString:[[arr_nearbyUsers objectAtIndex:i]valueForKey:@"profile_pic"]];
                NSData *imageData =[[NSData alloc] initWithBase64EncodedString:[[arr_nearbyUsers objectAtIndex:i]valueForKey:@"profile_pic"] options:0];  //[NSData dataWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:imageData];
                if (i==0) {
                    _imgview1.image=img;
                }
                else if (i==1)
                {
                    _imgview2.image=img;
                }
                else if (i==2)
                {
                    _imgview3.image=img;
                }
            }
        }
        else if (arr_nearbyUsers.count==4)
        {
            for (int i=0; i<arr_nearbyUsers.count; i++) {
//                NSURL *url = [NSURL URLWithString:[[arr_nearbyUsers objectAtIndex:i]valueForKey:@"profile_pic"]];
                NSData *imageData =[[NSData alloc] initWithBase64EncodedString:[[arr_nearbyUsers objectAtIndex:i]valueForKey:@"profile_pic"] options:0];  //[NSData dataWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:imageData];
                if (i==0) {
                    _imgview1.image=img;
                }
                else if (i==1)
                {
                    _imgview2.image=img;
                }
                else if (i==2)
                {
                    _imgview3.image=img;
                }
                else if (i==3)
                {
                    _imgview4.image=img;
                }
            }
        }
        else if (arr_nearbyUsers.count==5)
        {
            for (int i=0; i<arr_nearbyUsers.count; i++) {
                //                NSURL *url = [NSURL URLWithString:[[arr_nearbyUsers objectAtIndex:i]valueForKey:@"profile_pic"]];
                NSData *imageData =[[NSData alloc] initWithBase64EncodedString:[[arr_nearbyUsers objectAtIndex:i]valueForKey:@"profile_pic"] options:0];  //[NSData dataWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:imageData];
                if (i==0) {
                    _imgview1.image=img;
                }
                else if (i==1)
                {
                    _imgview2.image=img;
                }
                else if (i==2)
                {
                    _imgview3.image=img;
                }
                else if (i==3)
                {
                    _imgview4.image=img;
                }
                else if (i==4)
                {
                    _imgview5.image=img;
                }
            }
        }
        else if (arr_nearbyUsers.count==6)
        {
            for (int i=0; i<arr_nearbyUsers.count; i++) {
                //                NSURL *url = [NSURL URLWithString:[[arr_nearbyUsers objectAtIndex:i]valueForKey:@"profile_pic"]];
                NSData *imageData =[[NSData alloc] initWithBase64EncodedString:[[arr_nearbyUsers objectAtIndex:i]valueForKey:@"profile_pic"] options:0];  //[NSData dataWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:imageData];
                if (i==0) {
                    _imgview1.image=img;
                }
                else if (i==1)
                {
                    _imgview2.image=img;
                }
                else if (i==2)
                {
                    _imgview3.image=img;
                }
                else if (i==3)
                {
                    _imgview4.image=img;
                }
                else if (i==4)
                {
                    _imgview5.image=img;
                }
                else if (i==5)
                {
                    _imgview6.image=img;
                }
            }
        }
        
    }
}
- (void)labelDragged:(UIPanGestureRecognizer *)gesture
{
    UIImageView *label = (UIImageView *)gesture.view;
    CGPoint translation = [gesture translationInView:label];
     UIView *view=gesture.view;
    // move label
    label.center = CGPointMake(label.center.x + translation.x,
                               label.center.y + translation.y);
    
    if ((label.frame.origin.x>220)&&(label.frame.origin.y>327)) {
        
        NSLog(@"Match");
        if ([UIScreen mainScreen].bounds.size.height<=568) {
            
          label.frame=CGRectMake(227, 329, _imgview1.frame.size.width,_imgview1.frame.size.height );
            [label removeGestureRecognizer:gesture];
            
        }
       else
       {
          label.frame=CGRectMake(237, 339, _imgview1.frame.size.width,_imgview1.frame.size.height );
           [label removeGestureRecognizer:gesture];
       }
        
        if (!apiCalled) {
            
//            [label removeGestureRecognizer:gesture];
            ServerConnection *mServerConnection=[[ServerConnection alloc]init];
            mServerConnection.delegate=self;
            [mServerConnection add_to_interestList:mUser.user_ID user_email:mUser.userEmailID interested_id:[NSString stringWithFormat:@"%@",[[arr_nearbyUsers objectAtIndex:view.tag]valueForKey:@"id"]] interested_email:[NSString stringWithFormat:@"%@",[[arr_nearbyUsers objectAtIndex:view.tag]valueForKey:@"email"]]];
            apiCalled=YES;
            _img_beaker.animationImages=images;
            _img_beaker.animationDuration=0.5;
            [_img_beaker startAnimating];
        }
        
        //[_imgview1 removeGestureRecognizer:gesture];
//        HomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
////        [self presentViewController:vc animated:YES completion:nil];
//        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
    // reset translation
    [gesture setTranslation:CGPointZero inView:label];
    
    if(gesture.state == UIGestureRecognizerStateEnded)
    {
        //All fingers are lifted.
        NSLog(@"End");
        [UIView animateWithDuration:.34 animations:^{
            
           _imgview1.frame=frameimg;
            _imgview2.frame=frameimg1;
            _imgview3.frame=frameimg2;
            _imgview4.frame=frameimg3;
            _imgview5.frame=frameimg4;
            _imgview6.frame=frameimg5;
            
            
        }];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn_SmallAtom:(id)sender {
    
    ProfileDetailsViewController *hvc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileDetailsViewController"];
    
    [self.navigationController pushViewController:hvc animated:YES];

}
#pragma mark -ServerConnection Delegate
-(void)add_to_interestList:(id)result
{
     NSLog(@"%@",result);
    if([result isKindOfClass:[NSError class]]){
        [Utility showAlertWithTitle:ALERT_TITLE message:@"Networking problem.\n Try again."];
    }
    else if ([result isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = (NSDictionary *)result;
        if([[dict valueForKey:@"success"] integerValue]==1){
            
            [UIView animateWithDuration:.34 animations:^{
                
                HomeViewController *vcHome=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
                
                CATransition* transition = [CATransition animation];
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
                transition.duration = 0.7f;
                transition.type =  @"rippleEffect";
                [self.navigationController.view.layer removeAllAnimations];
                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                
                [self.navigationController pushViewController:vcHome animated:YES];
                
            }];
            
            
            
            
//            [Utility showAlertWithTitle:ALERT_TITLE message:[dict valueForKey:@"message"]];
//            HomeViewController *vcLoginViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//            [UIView  beginAnimations: @"rippleEffect"context: nil];
//            [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
//            [UIView setAnimationDuration:0.75];
//            [self.navigationController pushViewController: vcLoginViewController animated:NO];
//            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
//            [UIView commitAnimations];
//            arr_nearbyUsers=[[NSMutableArray alloc]initWithArray:[dict valueForKey:@"list"] copyItems:YES];
//            NSLog(@"Listing:- %@",arr_nearbyUsers);
//            [self viewWillAppear:YES];
        }
        else{
            [Utility showAlertWithTitle:ALERT_TITLE message:[dict valueForKey:@"message"]];
        }
    }
    else{
        [Utility showAlertWithTitle:ALERT_TITLE message:@"Network Problem."];
    }
}
-(void)get_near_by_users:(id)result
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
            
            arr_nearbyUsers=[[NSMutableArray alloc]initWithArray:[dict valueForKey:@"list"] copyItems:YES];
            NSLog(@"Listing:- %@",arr_nearbyUsers);
            
            [self viewWillAppear:YES];
        }
        else{
            [Utility showAlertWithTitle:ALERT_TITLE message:[dict valueForKey:@"message"]];
        }
    }
    else{
        [Utility showAlertWithTitle:ALERT_TITLE message:@"Network Problem."];
    }

    
}
#pragma mark - UITableView Datasource and Delegate Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 58.0f;
    }
    else
    {
        return 141.0f;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        NearbyUserUITableViewCell *cellProfile = [tableView dequeueReusableCellWithIdentifier:@"NearbyUserUITableViewCell"];
        
        cellProfile = (NearbyUserUITableViewCell *)[[[NSBundle mainBundle]loadNibNamed:@"NearbyUserUITableViewCell" owner:self options:0]objectAtIndex:0];
        cellProfile.vw_ProfileCell.layer.cornerRadius = 8.0;
        cellProfile.vw_profileHeader.layer.cornerRadius=8.0;
        
        cellProfile.imgVw_User.layer.cornerRadius = cellProfile.imgVw_User.frame.size.width/2;
        cellProfile.imgVw_User.layer.borderColor = [UIColor whiteColor].CGColor;
        cellProfile.imgVw_User.layer.borderWidth = 2.0f;
        cellProfile.imgVw_User.layer.masksToBounds = YES;
        
        if (arr_nearbyUsers>0) {
            
            NSData *imageData =[[NSData alloc] initWithBase64EncodedString:[[arr_nearbyUsers objectAtIndex:tappedImage]valueForKey:@"profile_pic"] options:0];  //[NSData dataWithContentsOfURL:url];
            UIImage *img1 = [UIImage imageWithData:imageData];
            cellProfile.imgVw_User.image=img1;
        }
       
        
//        cellProfile.lbl_UserName.text = [NSString stringWithFormat:@"%@ %@",(objUser.userFirstName.length>0)?(objUser.userFirstName):(@""),(objUser.userLastName.length>0)?(objUser.userLastName):(@"")];
        
        return cellProfile;
        
    }
    else if (indexPath.row==1)
    {
        PersonalInfoTableViewCell *cellProfile = [tableView dequeueReusableCellWithIdentifier:@"PersonalInfoTableViewCell"];
        cellProfile = (PersonalInfoTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:@"PersonalInfoTableViewCell" owner:self options:nil]objectAtIndex:0];
        if (arr_nearbyUsers.count>0) {
            
            cellProfile.lbl_userName.text=[[arr_nearbyUsers objectAtIndex:tappedImage]valueForKey:@"fullname"];
            cellProfile.lbl_userEmail.text=[[arr_nearbyUsers objectAtIndex:tappedImage]valueForKey:@"email"];
        }
        
        
//        cellProfile.lbl_userName=[]
//        cellProfile.lbl_userName.text = [NSString stringWithFormat:@"%@ %@",(objUser.userFirstName.length>0)?(objUser.userFirstName):(@""),(objUser.userLastName.length>0)?(objUser.userLastName):(@"")];
//        cellProfile.lbl_UserEmail.text=[NSString stringWithFormat:@"%@",(objUser.userEmailID.length>0)?(objUser.userEmailID):(@"")];
//        [cellProfile.lbl_address sizeToFit];
//        if ([DataValidation isNullString:[NSString stringWithFormat:@"%@",objUser.userAddress]]) {
//            cellProfile.lbl_address.text =@"";
//        }
//        else
//        {
//            cellProfile.lbl_address.text = [NSString stringWithFormat:@"%@",(objUser.userAddress.length>0)?(objUser.userAddress):(@"")];
//        }
        return cellProfile;
    }
    else
    {
        UITableViewCell *cell;
        return cell;
    }
    
}
-(void)tapDetected:(UITapGestureRecognizer*)sender{
    UIView *view=sender.view;
    tappedImage=view.tag;
    NSLog(@"single Tap on imageview %ld",view.tag);
    NSInteger count;
    if (!arr_nearbyUsers) {
        count=0;
    }
    else
    {
        count=arr_nearbyUsers.count;
    }
    if (tappedImage>count-1) {
        NSLog(@"Blank Fire");
        _vw_userDetails.hidden=YES;
    }
    else
    {
        [UIView animateWithDuration:.34 animations:^{
            
          _vw_userDetails.hidden=NO;
            
        }];
        
        [_tblvw_userDetails reloadData];
    }
    
}
@end
