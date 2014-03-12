//
//  AssignEmployeeViewController.m
//  Recipe 33 - Using Core Data
//
//  Created by joseph hoffman on 3/3/14.
//  Copyright (c) 2014 NSCookbook. All rights reserved.
//

#import "AssignEmployeeViewController.h"
#import "Employee.h"
#import "EmployeeTableViewController.h"

@interface AssignEmployeeViewController () <UITableViewDataSource>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UILabel *managerName;
@property (strong, nonatomic) Manager *manager;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addEmployees:(id)sender;
@end

@implementation AssignEmployeeViewController

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

- (IBAction)addEmployees:(id)sender
{
    EmployeeTableViewController *employeeTableViewController = [[EmployeeTableViewController alloc] initWithManager:self.manager andManagedContext:self.managedObjectContext];
    
    [self.navigationController pushViewController:employeeTableViewController animated:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.managerName.text = self.manager.name;
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.manager.employees.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"EmployeeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    }
    
    Employee *employee = [self.manager.employees.allObjects objectAtIndex:indexPath.row];
    
    cell.textLabel.text = employee.name;
    cell.detailTextLabel.text = employee.title;
    
    return cell;
    
}


@end
