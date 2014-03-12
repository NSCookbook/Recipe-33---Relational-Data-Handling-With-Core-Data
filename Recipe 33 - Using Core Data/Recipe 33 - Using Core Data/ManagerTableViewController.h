//
//  ManagerTableViewController.h
//  Recipe 33 - Using Core Data
//
//  Created by joseph hoffman on 3/1/14.
//  Copyright (c) 2014 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerTableViewController : UITableViewController

- (id) initWithManagedObjectContxt:(NSManagedObjectContext *)context;

@end
