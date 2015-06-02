//
//  JsonMapper.m
//  StudentsRecord
//
//  Created by Umair Aamir on 23/05/2015.
//  Copyright (c) 2015 Umair Aamir. All rights reserved.
//

#import "JsonMapper.h"
#import "DCArrayMapping.h"
#import "DCPropertyAggregator.h"
#import "DCObjectMapping.h"
#import "DCParserConfiguration.h"

#import "StudentsHolder.h"

@interface JsonMapper ()

@property (strong, nonatomic) DCParserConfiguration *config;
@end

@implementation JsonMapper

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.config = [DCParserConfiguration configuration];
    }
    return self;
}

- (void)dealloc
{
    self.config = nil;
}

#pragma mark - Mappers

+ (DCKeyValueObjectMapping *)studentsMapper
{
    JsonMapper *jsonParser = [[JsonMapper alloc] init];
    [jsonParser studentsConfiguration:jsonParser.config];
    return [DCKeyValueObjectMapping mapperForClass:[StudentsHolder class]
                                  andConfiguration:jsonParser.config];
}

#pragma mark - Response Mapping

- (void)studentsConfiguration:(DCParserConfiguration *)config
{
    [config addArrayMapper:[DCArrayMapping mapperForClassElements:[Student class] forAttribute:@"students" onClass:[StudentsHolder class]]];
    [config addArrayMapper:[DCArrayMapping mapperForClassElements:[Semester class] forAttribute:@"semesters" onClass:[Student class]]];
}

@end
