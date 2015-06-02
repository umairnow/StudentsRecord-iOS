//
//  SemesterListVC.m
//  StudentsRecord
//
//  Created by Umair Aamir on 26/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "SemesterListVC.h"

@interface SemesterListVC ()
@property (weak, nonatomic) NSArray *semesters;
@end

@implementation SemesterListVC

static NSString * const CellIdentifier = @"SemesterGrades";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.semesters = self.currentStudent.semesters;
}

- (void)dealloc
{
    self.semesters = nil;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.semesters.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Semester *semester = self.semesters[indexPath.row];
    cell.textLabel.text = semester.semester;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Grade: %@", semester.grade];
    return cell;
}

@end
