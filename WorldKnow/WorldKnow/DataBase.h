//
//  DataBase.h
//  WorldKnow
//
//  Created by 张福润 on 16/3/4.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FirstModel.h"
@interface DataBase : NSObject
+(DataBase *)shareDataBase;


-(void)openDBWithTable:(NSString *)userName;

-(BOOL)addWithNews:(FirstModel *)model
         tableName:(NSString *)userName;

-(NSMutableArray *)selectWithTableName:(NSString *)userName;
-(void)delecteWithPocid:(NSString *)pocid
              tableName:(NSString *)userName;

-(void)deleteTableName:(NSString *)userName;
-(void)closeDB;

@end
