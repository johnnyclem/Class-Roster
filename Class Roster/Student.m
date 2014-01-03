//
//  Student.m
//  Class Roster
//
//  Created by John Clem on 1/3/14.
//  Copyright (c) 2014 John Clem. All rights reserved.
//

#import "Student.h"

@implementation Student

- (instancetype) initWithName:(NSString *)name
{
    if (self = [super init]) {
        self.name = name;
    }
    
    return self;
    
}

@end
