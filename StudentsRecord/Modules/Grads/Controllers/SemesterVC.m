//
//  GradesDetailVC.m
//  StudentsRecord
//
//  Created by Umair Aamir on 26/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "SemesterVC.h"
#import "SemesterDetailContainerVC.h"

@interface SemesterVC ()

@property (strong, nonatomic) SemesterDetailContainerVC *semesterDetailContainerVC;
@end

@implementation SemesterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)dealloc
{
    self.semesterDetailContainerVC = nil;
}

- (void)setCurrentStudent:(Student *)currentStudent
{
    _currentStudent = currentStudent;
    self.title = currentStudent.name;
}

#pragma mark - Action Handler

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender
{
    [self.semesterDetailContainerVC swapViewControllers];
}

#pragma mark - Segue Action Handler

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SEGUE_EMBED_CONTAINER]) {
        self.semesterDetailContainerVC = segue.destinationViewController;
        self.semesterDetailContainerVC.currentStudent = self.currentStudent;
    }
}

@end
