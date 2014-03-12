//
//  Employee.h
//  Recipe 33 - Using Core Data
//
//  Created by joseph hoffman on 3/1/14.
//  Copyright (c) 2014 NSCookbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Manager;

@interface Employee : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Manager *manager;

@end
