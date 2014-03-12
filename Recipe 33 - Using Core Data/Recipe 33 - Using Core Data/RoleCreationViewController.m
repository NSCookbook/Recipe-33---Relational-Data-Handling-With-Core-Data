//
//  RoleCreationViewController.m
//  Recipe 33 - Using Core Data
//
//  Created by joseph hoffman on 3/1/14.
//  Copyright (c) 2014 NSCookbook. All rights reserved.
//

#import "RoleCreationViewController.h"
#import "Manager.h"
#import "Employee.h"

#define EMPLOYEE 0

@interface RoleCreationViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *personName;
@property (weak, nonatomic) IBOutlet UITextField *personTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *personRoleType;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (IBAction)savePerson:(id)sender;

@end

@implementation RoleCreationViewController

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

-(id)initWithManagedObjectContext:(NSManagedObjectContext *)context

{
    self = [super init];
    if (self)
    {
        self.managedObjectContext = context;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.personName.delegate = self;
    self.personTitle.delegate = self;
}

- (IBAction)savePerson:(id)sender
{
    if(self.personName && self.personTitle && self.personRoleType)
    {
        if(self.personRoleType.selectedSegmentIndex == EMPLOYEE)
        {
            NSEntityDescription *employeeEntityDescription = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:self.managedObjectContext];
            
            //NSLog(@" employeeEntity %@",employeeEntityDescription);
            
            Employee *newEmployee = (Employee *)[[NSManagedObject alloc] initWithEntity:employeeEntityDescription
                                                         insertIntoManagedObjectContext:self.managedObjectContext];
            
            newEmployee.name = self.personName.text;
            newEmployee.title = self.personTitle.text;
            
        }
        else
        {
            
            NSEntityDescription *managerEntityDescription = [NSEntityDescription entityForName:@"Manager" inManagedObjectContext:self.managedObjectContext];
            
            //NSLog(@" employeeEntity %@",managerEntityDescription);
            
            Manager *newManager = (Manager *)[[NSManagedObject alloc] initWithEntity:managerEntityDescription
                                                         insertIntoManagedObjectContext:self.managedObjectContext];
            
            newManager.name = self.personName.text;
            newManager.title = self.personTitle.text;
            
            
        }
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Missing Inforamtion" message:@"Hey man you totally forgot to input some information!" delegate:nil cancelButtonTitle:@"Got It!" otherButtonTitles:nil];
        [alertView show];
        
        
    }
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
@end
