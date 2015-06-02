//
//  GradsVC.m
//  StudentsRecord
//
//  Created by Umair Aamir on 25/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "GradesVC.h"
#import "SemesterVC.h"

@interface GradesVC ()

@property (weak, nonatomic) NSArray *students;
@end

@implementation GradesVC

static NSString * const CellIdentifier = @"StudentsNames";

#pragma mark - Load Grades

+ (UINavigationController *)loadGradesVC
{
    static UINavigationController *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[UIStoryboard storyboardGrades] instantiateInitialViewController];
    });
    return _sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAppearance];
    [self loadData];
}

#pragma mark - Helping Methods

- (void)setupAppearance
{
    [self addMenuButton];
}

- (void)loadData
{
    self.students = utility.studentHolder.students;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.students.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Student *student = self.students[indexPath.row];
    cell.textLabel.text = student.name;
    return cell;
}

#pragma mark - Segue Handler

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SEGUE_STUDENT_DETAIL]) {
        Student *student = self.students[[self.tableView indexPathForSelectedRow].row];
        ((SemesterVC *)(segue.destinationViewController)).currentStudent = student;
    }
}

@end
