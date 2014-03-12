//
//  ManagerTableViewController.m
//  Recipe 33 - Using Core Data
//
//  Created by joseph hoffman on 3/1/14.
//  Copyright (c) 2014 NSCookbook. All rights reserved.
//

#import "ManagerTableViewController.h"
#import "Manager.h"
#import "AssignEmployeeViewController.h"

@interface ManagerTableViewController ()

@property (strong, nonatomic)NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic)NSFetchedResultsController *fetchedResultsController;

@end

@implementation ManagerTableViewController

- (id)initWithManagedObjectContxt:(NSManagedObjectContext *)context
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self)
    {
        self.managedObjectContext = context;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Managers";
    [self fetchManagers];

}
- (void)viewDidAppear:(BOOL)animated
{
    
        [self fetchManagers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    static NSString *CellIdentifier = @"ManagerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Manager *manager = (Manager *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = manager.name;
    cell.detailTextLabel.text = manager.title;
    
    return cell;
}

# pragma mark - helper methods

- (void)fetchManagers
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Manager"];
    NSString *cacheName = @"ManagerCache";
    
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
    
    Manager *manager = (Manager *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    AssignEmployeeViewController *assignEmployeeViewController = [[AssignEmployeeViewController alloc] initWithManager:manager andManagedContext:self.managedObjectContext];
    
    [self.navigationController pushViewController:assignEmployeeViewController animated:YES];
}



@end
