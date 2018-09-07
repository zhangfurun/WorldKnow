//
//  NewsDetailImageCell.m
//  WorldKnow
//
//  Created by 张福润 on 2017/3/18.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "NewsDetailImageCell.h"

#import "NewsDetailItem.h"

#import "YYWebImage.h"

@interface NewsDetailImageCell ()
///图片
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
///图片标题
@property (weak, nonatomic) IBOutlet UILabel *imageTitleLabel;
@end

@implementation NewsDetailImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.imageTitleLabel.text = _title;
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self.newsImageView yy_setImageWithURL:[NSURL URLWithString:_imageUrl] options:YYWebImageOptionProgressiveBlur];
}

- (UIImage *)shareImage {
    
    return self.newsImageView.image ? : nil;
}
@end
