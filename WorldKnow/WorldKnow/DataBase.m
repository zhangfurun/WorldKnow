//
//  DataBase.m
//  WorldKnow
//
//  Created by 张福润 on 16/3/4.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "DataBase.h"
static DataBase *share=nil;
static sqlite3 *db=nil;
@implementation DataBase
+(DataBase *)shareDataBase{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share=[[DataBase alloc]init];
    });
    return share;
}
-(void)openDBWithTable:(NSString *)userName{
    if(!db){
        //存到沙盒中
        NSString *filePath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:@"/user.sqlite"];
        NSLog(@"%@",filePath);
        int result=sqlite3_open(filePath.UTF8String, &db);
        if(result==SQLITE_OK){
            NSLog(@"打开成功");
            
            NSString *sql=[NSString stringWithFormat:@"CREATE  TABLE  IF NOT EXISTS MY_NEWS_%@ (postid TEXT PRIMARY KEY  NOT NULL , ltitle TEXT , digest TEXT)",userName];
            
            int result1= sqlite3_exec(db,  sql.UTF8String,NULL ,NULL, NULL);
            if(result1==SQLITE_OK){
                NSLog(@"创建表格成功");
                
            }
            else{
                NSLog(@"创建表格成功");
            }
            
        }
        else {
            NSLog(@"打开失败");
        }
        
        
    }

}

-(BOOL)addWithNews:(FirstModel *)model
         tableName:(NSString *)userName{
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO MY_NEWS_%@ (postid , ltitle ,digest ) VALUES ('%@','%@','%@')",userName,model.postid,model.ltitle,model.digest];
    
    int result= sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    NSLog(@"%d",result);
    if(result==SQLITE_OK){
        NSLog(@"添加数据成功");
        return YES;
    }
    else{
        NSLog(@"添加数据失败");
        return NO;
    }

    
}

-(NSMutableArray *)selectWithTableName:(NSString *)userName;{
    NSMutableArray *arr=[NSMutableArray array];
    
    
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM MY_NEWS_%@",userName];
    sqlite3_stmt *stmt=nil;
    
    int result=sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    if(result==SQLITE_OK){
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            FirstModel *model=[[FirstModel alloc]init];
            char *selectPostid=(char *)sqlite3_column_text(stmt, 0);
            NSString *pocid=[NSString stringWithCString:selectPostid encoding:NSUTF8StringEncoding];
            
            model.postid=pocid;
            
            
            char *selectTitle=(char *)sqlite3_column_text(stmt, 1);
            NSString *title=[NSString stringWithCString:selectTitle encoding:NSUTF8StringEncoding];
            
            model.ltitle=title;
            
            
            
            char *selectdigest=(char *)sqlite3_column_text(stmt, 2);
            NSString *digest=[NSString stringWithCString:selectdigest encoding:NSUTF8StringEncoding];
            
            model.digest=digest;
            
            
            
            
            //            NSLog(@"%@",model);
            [arr addObject:model];
        }
    }
    sqlite3_finalize(stmt);
    return arr;

}
//
//
-(void)delecteWithPocid:(NSString *)pocid
              tableName:(NSString *)userName{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM MY_NEWS_%@ WHERE postid = '%@'",userName,pocid];
    int result=sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"删除数据成功");
        
    }else{
        NSLog(@"删除数据失败");
        NSLog(@"%d",result);
        
    }
    
}
//
-(void)deleteTableName:(NSString *)userName{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM MY_NEWS_%@",userName];
    int result=sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    NSLog(@"result=%d",result);
    if (result == SQLITE_OK) {
        NSLog(@"删除表格成功");
        
    }else{
        NSLog(@"删除表格失败");
        
    }
    
}
-(void)closeDB{
    if(db!=nil){
        int result=sqlite3_close(db);
        if(result==SQLITE_OK){
            db=nil;
            NSLog(@"关闭数据库成功");
        }
        else{
            
            NSLog(@"关闭数据库失败");
        }
    }
}
//
@end
