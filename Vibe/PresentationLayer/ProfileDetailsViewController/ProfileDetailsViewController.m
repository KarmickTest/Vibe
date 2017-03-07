//
//  ProfileDetailsViewController.m
//  Vibe
//
//  Created by SAYAN MAC MINI on 2/16/17.
//  Copyright © 2017 Karmickkarmick. All rights reserved.
//

#import "ProfileDetailsViewController.h"
#import "ProfileCollectionViewCell.h"
#import "EditProfileViewController.h"
#import "Constant.h"
@interface ProfileDetailsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ServerConnectionDelegate>
{
    User *mUser;
    SpinnerView *mSpinnerView;
    NSInteger testIndexPath;;
}
@property (strong, nonatomic) IBOutlet UIImageView *img_Profile;
@property (strong, nonatomic) IBOutlet UILabel *lbl_name;
@property (strong, nonatomic) IBOutlet UILabel *country;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Age;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionVW_interestList;
@property (strong, nonatomic) IBOutlet UIImageView *img_logo;

@end

@implementation ProfileDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self autoScroll];
    
    
    mUser = [User new];
    mUser = [Utility getUserInfo];
    
    mSpinnerView=[[SpinnerView alloc]init];
    [self.view setUserInteractionEnabled:NO];
    [mSpinnerView setOnView:self.view withTextTitle:@"Loading..." withTextColour:[UIColor whiteColor] withBackgroundColour:[UIColor blackColor] animated:YES];
    
    ServerConnection *mServerConnection=[[ServerConnection alloc]init];
    mServerConnection.delegate=self;
    [mServerConnection interestList:mUser.userEmailID id:mUser.user_ID];
    
    NSData *imageData =[[NSData alloc] initWithBase64EncodedString:mUser.userPic options:0];  //[NSData dataWithContentsOfURL:url];
    UIImage *img1 = [UIImage imageWithData:imageData];
    _img_Profile.image=img1;
//    NSString *str = ;
//     [mUser.userFirstName stringByAppendingString:mUser.userLastName];
    _lbl_name.text=[NSString stringWithFormat:@"%@ %@",mUser.userFirstName,mUser.userLastName];
    
    arr_interestList=[[NSMutableArray alloc]init];
    
    
}
-(void)autoScroll{
    CGFloat point = _collectionVW_interestList.contentOffset.x;
    CGFloat lo = point + 1;
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _collectionVW_interestList.contentOffset = CGPointMake(lo, 0);
    }completion:^(BOOL finished){
        if (testIndexPath==arr_interestList.count)
        {
            [self autoScrollReverse];
        }
        else{
            [self autoScroll];
        }
    }];
}

-(void)autoScrollReverse{
    CGFloat point = _collectionVW_interestList.contentOffset.x;
    CGFloat lo = point - 1;
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _collectionVW_interestList.contentOffset = CGPointMake(lo, 0);
    }completion:^(BOOL finished){
        if(testIndexPath == 0){
            [self autoScroll];
        }else{
            [self autoScrollReverse];
            
        }
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    rotationAnimation.toValue = [NSNumber numberWithFloat: 2*M_PI];
    rotationAnimation.duration = 10.0f;;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INFINITY;
    
    [_img_logo.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Uicollection DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [arr_interestList count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [collectionView registerNib:[UINib nibWithNibName:@"ProfileCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ProfileCollectionViewCell"];
    
    ProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionViewCell" forIndexPath:indexPath];;
    
    if (cell==nil)
    {
        cell =(ProfileCollectionViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"ProfileCollectionViewCell" owner:self options:nil] objectAtIndex:0];
    }
    NSData *imageData =[[NSData alloc] initWithBase64EncodedString:[[arr_interestList objectAtIndex:indexPath.item]valueForKey:@"profile_pic"] options:0];  //[NSData dataWithContentsOfURL:url];
    UIImage *img1 = [UIImage imageWithData:imageData];
    cell.img_collection.image=img1;
    cell.img_collection.layer.cornerRadius = 10.0;
    cell.img_collection.layer.masksToBounds = YES;
    testIndexPath=indexPath.row;
//    fullname
    cell.lbl_userName.text=[[arr_interestList objectAtIndex:indexPath.item]valueForKey:@"firstname"];
    return cell;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn_editProfile:(id)sender {
    
    EditProfileViewController *hvc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EditProfileViewController"];
    
    [self.navigationController pushViewController:hvc animated:YES];

}

- (IBAction)btn_Back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)interestList:(id)result
{
    [self.view setUserInteractionEnabled:YES];
    [mSpinnerView hideFromView:self.view animated:YES];
    if([result isKindOfClass:[NSError class]]){
        [Utility showAlertWithTitle:ALERT_TITLE message:@"Networking problem.\n Try again."];
    }
    else if ([result isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = (NSDictionary *)result;
        if([[dict valueForKey:@"success"] integerValue]==1){
            
            arr_interestList=[[NSMutableArray alloc]initWithArray:[dict valueForKey:@"list"] copyItems:YES];
            [_collectionVW_interestList reloadData];
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

@end
