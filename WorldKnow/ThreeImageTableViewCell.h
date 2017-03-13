//
//  ThreeImageTableViewCell.h
//  WorldKnow
//
//  Created by 张福润 on 16/3/7.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFirst;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSecond;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThree;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelTie;


@end
