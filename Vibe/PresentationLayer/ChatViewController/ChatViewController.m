//
//  ChatViewController.m
//  Vibe
//
//  Created by Somnath on 07/03/17.
//  Copyright © 2017 Karmickkarmick. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.chatTextView.layer.borderWidth = 1.0f;
    self.chatTextView.layer.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1].CGColor;
    self.chatTextView.layer.cornerRadius = 2.0f;
    self.chatTextView.clipsToBounds = YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0)
    {
        leftCell = (chatLeftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"chatLeftTableViewCell"];
        return leftCell;
    }
    else
    {
        rightCell = (chatRightTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"chatRightTableViewCell"];
        return rightCell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
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

@end
