//
//  ChatViewController.h
//  Vibe
//
//  Created by Somnath on 07/03/17.
//  Copyright © 2017 Karmickkarmick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chatLeftTableViewCell.h"
#import "chatRightTableViewCell.h"


@interface ChatViewController : UIViewController
{
    chatLeftTableViewCell *leftCell;
    chatRightTableViewCell *rightCell;
}

@property (weak, nonatomic) IBOutlet UIView *chatSendView;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UITextView *chatTextView;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@end
