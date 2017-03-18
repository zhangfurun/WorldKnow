//
//  NewsDetailWebCell.m
//  WorldKnow
//
//  Created by 张福润 on 2017/3/18.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "NewsDetailWebCell.h"

@interface NewsDetailWebCell ()
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@end

@implementation NewsDetailWebCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setWebString:(NSString *)webString {
    _webString = webString;
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[_webString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.bodyLabel.attributedText = attrStr;

}

@end
