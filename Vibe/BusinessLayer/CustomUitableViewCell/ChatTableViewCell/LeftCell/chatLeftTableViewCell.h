//
//  chatLeftTableViewCell.h
//  Vibe
//
//  Created by Somnath on 07/03/17.
//  Copyright © 2017 Karmickkarmick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chatLeftTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIView *chatTextContainerView;
@property (weak, nonatomic) IBOutlet UILabel *chatTextLbl;
@property (weak, nonatomic) IBOutlet UIImageView *leftSideView;
@end
