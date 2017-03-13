//
//  FirstDetailViewController.h
//  WorldKnow
//
//  Created by 张福润 on 16/2/2.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstModel.h"
#import "FirstDetilModel.h"
@interface FirstDetailViewController : UIViewController
@property (nonatomic,strong)FirstModel * model;

///当前数据Model
@property (nonatomic,strong)FirstDetilModel * detilModel;

@property (nonatomic,strong)NSString * postid;

///要分享的image
@property (nonatomic,strong)UIImage * imageShare;

@end
