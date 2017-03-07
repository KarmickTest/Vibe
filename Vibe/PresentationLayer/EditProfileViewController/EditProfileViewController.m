//
//  EditProfileViewController.m
//  Vibe
//
//  Created by Admin on 17/02/17.
//  Copyright © 2017 Karmickkarmick. All rights reserved.
//

#import "EditProfileViewController.h"


@interface EditProfileViewController ()<UITextViewDelegate,UITextFieldDelegate>
{
//    CGRect heightKeyboard;
    float heightKeyboard;
    CGRect SelfViewFrame;
    
}
@property (strong, nonatomic) IBOutlet UITextField *txtFld_userNameEdit;
@property (strong, nonatomic) IBOutlet UITextField *txtFld_userProvince;
@property (strong, nonatomic) IBOutlet UITextView *txtVw_ShortDesc;
@property (strong, nonatomic) IBOutlet UIImageView *img_atomLogo;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SelfViewFrame=self.view.frame;
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *singleTap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    [self.view addGestureRecognizer:singleTap6];
    self.view.tag=1024;
    
    
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
    
    [_img_atomLogo.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
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
#pragma Mark-UitextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self animateTextView: YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self animateTextView:NO];
//    self.view.frame = SelfViewFrame;
    [textView resignFirstResponder];
}

- (void) animateTextView:(BOOL) up
{
    const int movementDistance =250.0; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    int movement= movement = (up ? -movementDistance : movementDistance);
    NSLog(@"%d",movement);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
    
}
- (void)myNotificationMethod:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    heightKeyboard=keyboardFrameBeginRect.size.height;
    [self animateTextView: YES];
    NSLog(@"%f",heightKeyboard);
}
-(void)tapDetected:(UITapGestureRecognizer*)sender{
    [self.view endEditing:YES];
}
- (IBAction)btn_Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
