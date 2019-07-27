//
//  CYTomatoTimerEventObjects.m
//  TomatoTimer
//
//  Created by confiwang on 2019/7/7.
//  Copyright © 2019 confiwang. All rights reserved.
//

#import "CYTomatoTimerEventObjects.h"

#import <WCDB/WCDB.h>

@interface CYTomatoTimerEventObjects () <WCTTableCoding>

WCDB_PROPERTY(timeriId)
WCDB_PROPERTY(startTime)
WCDB_PROPERTY(endTime)

@end

@implementation CYTomatoTimerEventObjects

WCDB_IMPLEMENTATION(CYTomatoTimerEventObjects)
WCDB_SYNTHESIZE(CYTomatoTimerEventObjects, timeriId)
WCDB_SYNTHESIZE(CYTomatoTimerEventObjects, startTime)
WCDB_SYNTHESIZE(CYTomatoTimerEventObjects, endTime)
WCDB_PRIMARY(CYTomatoTimerEventObjects, timeriId)


@end
