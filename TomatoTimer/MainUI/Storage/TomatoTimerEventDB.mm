//
//  TomatoTimerEventDB.m
//  TomatoTimer
//
//  Created by confiwang on 2019/7/7.
//  Copyright © 2019 confiwang. All rights reserved.
//

#import "TomatoTimerEventDB.h"

#import <WCDB/WCDB.h>
#import "CYTomatoTimerEventObjects.h"

#define kCYTomatoTimerEventObjectsTable @"event_objects"

@interface TomatoTimerEventDB ()

@property(nonatomic,strong)WCTDatabase *db;
@end

@implementation TomatoTimerEventDB

-(Boolean)initDB {
    NSString *dbPath = [self getDocPath];
    
    self.db = [[WCTDatabase alloc] initWithPath:dbPath];
    
    if (!self.db) {
        return NO;
    }
    
    if ([self.db createTableAndIndexesOfName:kCYTomatoTimerEventObjectsTable withClass:CYTomatoTimerEventObjects.class]) {
                
    } else {
        return NO;
    }
    return YES;
}

- (NSString *)getDocPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *rootDir = (NSString *)[paths objectAtIndex:0];
    return rootDir;
}
@end
