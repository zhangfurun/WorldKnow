//
//  NewsDetailTextCell.m
//  WorldKnow
//
//  Created by 张福润 on 2017/3/18.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "NewsDetailTextCell.h"

#import "NewsDetailItem.h"

@interface NewsDetailTextCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *comeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation NewsDetailTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDetailItem:(NewsDetailItem *)detailItem {
    _detailItem = detailItem;
    self.titleLabel.text = _detailItem.title;
    self.comeLabel.text = _detailItem.source;
    self.titleLabel.text = _detailItem.ptime;
}

#pragma mark - Action
- (IBAction)onShareBtnTap:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(newsDetailTextCell:didSharedWithItem:)]) {
        [self.delegate newsDetailTextCell:self didSharedWithItem:self.detailItem];
    }
}
@end
