//
//  EmployeeTableViewController.m
//  Recipe 33 - Using Core Data
//
//  Created by joseph hoffman on 3/1/14.
//  Copyright (c) 2014 NSCookbook. All rights reserved.
//

#import "EmployeeTableViewController.h"
#import "Manager.h"
#import "Employee.h"

@interface EmployeeTableViewController ()

@property (strong, nonatomic) Manager *manager;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (void)fetchEmployees;

@end

@implementation EmployeeTableViewController

-(id)initWithManager:(Manager *)manager andManagedContext:(NSManagedObjectContext *)context

{
    self = [super init];
    if (self)
    {
        self.managedObjectContext = context;
        self.manager = manager;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Employees";
    [self fetchEmployees];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EmployeeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Employee *employee = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = employee.name;
    cell.detailTextLabel.text = employee.title;
    
	return cell;
}


- (void)fetchEmployees
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    NSString *cacheName = @"EmplyeeCache";
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:cacheName];
    NSError *error;
    if(![self.fetchedResultsController performFetch:&error])
    {
        
        NSLog(@"Fetch Failure: %@",error);
    }
    
    [self.tableView reloadData];
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    Employee *employee = (Employee *)[self.fetchedResultsController objectAtIndexPath:indexPath];

    [self.manager addEmployeesObject:employee];
                                
         
    [self.navigationController popViewControllerAnimated:YES];

}



@end
