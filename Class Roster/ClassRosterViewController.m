//
//  ViewController.m
//  Class Roster
//
//  Created by John Clem on 01/03/14.
//  Copyright (c) 2013 John Clem. All rights reserved.
//

#import "ClassRosterViewController.h"
#import "BMInitialsPlaceholderView.h"
#import "StudentDetailViewController.h"
#import "Student.h"

NSString * const kViewControllerCellIdentifier = @"cell";
const CGFloat kViewControllerCellHeight = 50.0;

@interface ClassRosterViewController ()
{
    NSIndexPath *pathForSelectedCell;
}

@property (strong) NSMutableArray *students;

@end

@implementation ClassRosterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kViewControllerCellIdentifier];
    self.tableView.contentInset = self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    
    _students = [NSMutableArray new];
    NSArray *studentNames = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Students" ofType:@"plist"]];
    
    for (NSString *name in studentNames) {
        Student *student = [[Student alloc] initWithName:name];
        [_students addObject:student];
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (pathForSelectedCell) {
        [self.tableView reloadRowsAtIndexPaths:@[pathForSelectedCell] withRowAnimation:UITableViewRowAnimationFade];        
    }
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
    return [self.students count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kViewControllerCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kViewControllerCellIdentifier forIndexPath:indexPath];

    Student *student = _students[indexPath.row];
    
    UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0];
    CGFloat placeholderHW = kViewControllerCellHeight - 15;
    BMInitialsPlaceholderView *placeholder = [[BMInitialsPlaceholderView alloc] initWithDiameter:placeholderHW];
    placeholder.font = font;
    placeholder.initials = [self initialStringForPersonString:student.name];
    placeholder.circleColor = [self circleColorForIndexPath:indexPath];
    if (student.profilePicture) {
        placeholder.profilePicture = student.profilePicture;
    }
    
    cell.textLabel.font = font;
    cell.textLabel.text = student.name;
    cell.accessoryView = placeholder;
    
    return cell;
}

- (UIColor *)circleColorForIndexPath:(NSIndexPath *)indexPath {
    return [UIColor colorWithHue:arc4random() % 256 / 256.0 saturation:0.7 brightness:0.8 alpha:1.0];
}

- (NSString *)initialStringForPersonString:(NSString *)personString {
    NSArray *comps = [personString componentsSeparatedByString:@" "];
    if ([comps count] >= 2) {
        NSString *firstName = comps[0];
        NSString *lastName = comps[1];
        return [NSString stringWithFormat:@"%@%@", [firstName substringToIndex:1], [lastName substringToIndex:1]];
    } else if ([comps count]) {
        NSString *name = comps[0];
        return [name substringToIndex:1];
    }
    return @"Unknown";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    pathForSelectedCell = indexPath;
    [self performSegueWithIdentifier:@"ShowStudentDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[StudentDetailViewController class]]) {
        [segue.destinationViewController setStudent:_students[self.tableView.indexPathForSelectedRow.row]];
    }
}

@end
