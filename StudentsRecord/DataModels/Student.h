//
//  Student.h
//  StudentsRecord
//
//  Created by Umair Aamir on 25/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Semester.h"
#import "Location.h"

@interface Student : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) Location *location;
@property (strong, nonatomic) NSArray *semesters;

@end
