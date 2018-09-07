//
//  NewsListCell.m
//  WorldKnow
//
//  Created by 张福润 on 2017/3/14.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "NewsListCell.h"

#import "NewsItem.h"

//#import "UIImageView+WebCache.h"

#import "UIView+TTSuperView.h"
#import "YYWebImage.h"

@interface NewsListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *talkLabel;

@end

@implementation NewsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(NewsItem *)item {
    _item = item;
    [self.newsImageView yy_setImageWithURL:[NSURL URLWithString:_item.imgsrc] placeholder:nil options:YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
    if(_item.ltitle.length == 0){
        self.titleLabel.text = _item.title;
    }else{
        self.titleLabel.text = _item.ltitle;
    }
    self.detailLabel.text = _item.digest;
    self.talkLabel.text = [NSString stringWithFormat:@"%@回复",_item.replyCount];
}

- (IBAction)onCellBtnTap:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(newsListCell:didSelectedWithItem:)]) {
        [self.delegate newsListCell:self didSelectedWithItem:self.item];
    }
}

@end
