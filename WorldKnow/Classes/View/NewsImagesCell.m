//
//  NewsImagesCell.m
//  WorldKnow
//
//  Created by 张福润 on 2017/3/14.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "NewsImagesCell.h"

#import "NewsItem.h"

#import "YYWebImage.h"

@interface NewsImagesCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFirst;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSecond;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThree;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *talkLabel;
@end

@implementation NewsImagesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(NewsItem *)item {
    _item = item;
    self.titleLabel.text = _item.title;
    self.talkLabel.text=[NSString stringWithFormat:@"%@回复",_item.replyCount];
    [self.imageViewFirst setYy_imageURL:[NSURL URLWithString:_item.imgsrc]];
    [self.imageViewSecond setYy_imageURL:[NSURL URLWithString:_item.imgextra[0][@"imgsrc"]]];
    [self.imageViewThree setYy_imageURL:[NSURL URLWithString:_item.imgextra[1][@"imgsrc"]]];
}

#pragma mark - Action
- (IBAction)onCellBtnTap:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(newsImagesCell:didSelectedWithItem:)]) {
        [self.delegate newsImagesCell:self didSelectedWithItem:self.item];
    }
}

@end
