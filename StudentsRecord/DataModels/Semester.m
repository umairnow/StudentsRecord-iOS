//
//  Semester.m
//  StudentsRecord
//
//  Created by Umair Aamir on 25/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "Semester.h"

@implementation Semester

@synthesize grade = _grade;

- (NSString *)grade
{
    if (!_grade) {
        if (self.marks.integerValue < 20) {
            _grade = @"F";
        } else if (self.marks.integerValue < 40) {
            _grade = @"E";
        } else if (self.marks.integerValue < 60) {
            _grade = @"D";
        } else if (self.marks.integerValue < 65) {
            _grade = @"C";
        } else if (self.marks.integerValue < 70) {
            _grade = @"B";
        } else if (self.marks.integerValue < 85) {
            _grade = @"A";
        } else {
            _grade = @"A+";
        }
    }
    return _grade;
}

- (void)dealloc
{
    self.semester = nil;
    self.marks = nil;
}
@end
