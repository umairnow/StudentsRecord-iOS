//
//  JsonMapper.h
//  StudentsRecord
//
//  Created by Umair Aamir on 23/05/2015.
//  Copyright (c) 2015 Umair Aamir. All rights reserved.
//

#import <DCKeyValueObjectMapping/DCKeyValueObjectMapping.h>

@interface JsonMapper : NSObject

/**
 * Maps the students dictionary on model objects
 **/
+ (DCKeyValueObjectMapping *)studentsMapper;

@end
