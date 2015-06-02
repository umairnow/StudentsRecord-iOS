//
//  Semester.h
//  StudentsRecord
//
//  Created by Umair Aamir on 25/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Semester : NSObject

@property (strong, nonatomic) NSString *semester;
@property (strong, nonatomic) NSNumber *marks;
@property (readonly, nonatomic) NSString *grade;
@end
