//
//  EmployeeTableViewController.h
//  Recipe 33 - Using Core Data
//
//  Created by joseph hoffman on 3/1/14.
//  Copyright (c) 2014 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manager.h"

@interface EmployeeTableViewController : UITableViewController

-(id)initWithManager:(Manager *)manager andManagedContext:(NSManagedObjectContext *)context;

@end
