//
//  NewsImagesCell.h
//  WorldKnow
//
//  Created by 张福润 on 2017/3/14.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsImagesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFirst;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSecond;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThree;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelTie;


@end
