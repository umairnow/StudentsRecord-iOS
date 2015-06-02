//
//  SemesterBarVC.m
//  StudentsRecord
//
//  Created by Umair Aamir on 26/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "SemesterBarVC.h"
#import "BarView.h"

@interface SemesterBarVC ()

@property (weak, nonatomic) NSArray *semesters;
@end

@implementation SemesterBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeVariables];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadData];
}

- (void)initializeVariables
{
    self.semesters = self.currentStudent.semesters;
    barChartView.delegate = self;
    barChartView.dataSource = self;
}

- (void)loadData
{
    [barChartView reloadData];
}

#pragma mark - JBBarChart Delegate and Datasource

- (NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
    return self.semesters.count;
}
- (CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index
{
    Semester *semester = self.semesters[index];
    return semester.marks.floatValue;
}

- (UIView *)barChartView:(JBBarChartView *)barChartView barViewAtIndex:(NSUInteger)index
{
    BarView *barView = [[BarView alloc] init];
    UIColor *color = (index % 2 == 0) ? [UIColor blueColor]:[UIColor greenColor];
    barView.viewColor.backgroundColor = color;
    barView.lblSemester.text = ((Semester *)self.semesters[index]).semester;
    barView.lblGrade.text = [NSString stringWithFormat:@"Grade %@", ((Semester *)self.semesters[index]).grade];
    return barView;
}

- (CGFloat)barPaddingForBarChartView:(JBBarChartView *)barChartView
{
    return 10;
}


@end
