//
//  Student.m
//  StudentsRecord
//
//  Created by Umair Aamir on 25/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "Student.h"

@implementation Student

- (void)dealloc
{
    self.name = nil;
    self.location = nil;
    self.semesters = nil;
}
@end
