//
//  ImageTableViewCell.h
//  WorldKnow
//
//  Created by 张福润 on 16/3/1.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableViewCell : UITableViewCell
///图片
@property (weak, nonatomic) IBOutlet UIImageView *imV;

///图片标题
@property (weak, nonatomic) IBOutlet UILabel *labelImageTitle;
@end
