//
//  SRUtility.m
//  StudentsRecord
//
//  Created by Umair Aamir on 25/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "SRUtility.h"
#import "JsonMapper.h"
#import "TWMessageBarManager.h"
#import "MessageBarStyleSheet.h"

@interface SRUtility ()
@property (nonatomic, strong) TWMessageBarManager *messageBarManager;
@end

@implementation SRUtility

@synthesize studentHolder = _studentHolder;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.messageBarManager  = [TWMessageBarManager sharedInstance];
    }
    return self;
}

- (void)dealloc
{
    self.messageBarManager = nil;
}

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static SRUtility *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SRUtility alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - Other Methods

- (void)showSuccessMessageBarWithTitle:(NSString *)title andMessage:(NSString *)message
{
    [self showMessageBarWithTitle:title andMessage:message andType:TWMessageBarMessageTypeSuccess];
}

- (void)showErrorMessageBarWithTitle:(NSString *)title andMessage:(NSString *)message
{
    [self showMessageBarWithTitle:title andMessage:message andType:TWMessageBarMessageTypeError];
}

- (void)showMessageBarWithTitle:(NSString *)title andMessage:(NSString *)message andType:(TWMessageBarMessageType )messageType
{
    [self.messageBarManager showMessageWithTitle:title description:message type:messageType];
}

#pragma mark - Helping Methods

- (NSString *)directoryPath
{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:@"AppImages"];
}

- (NSURL *)directoryURL
{
    return [NSURL fileURLWithPath:[self directoryPath] isDirectory:YES];
}

- (void)saveImagesToAppData
{
    NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtURL:[self directoryURL]
                             withIntermediateDirectories:YES attributes:nil error:&error];
    if (!error) {
        dispatch_async(dispatch_queue_create("saveImage", NULL), ^{            
            for (NSInteger i=0; i<5; i++) {
                NSString *pathComponent = [NSString stringWithFormat:@"images-%ld.png", (long)i];
                [self saveImage:[UIImage imageNamed:pathComponent] withName:pathComponent];
            }
        });
    } else {
        ULog(@"Sorry, couldn't create directory");
    }
}

- (void)saveImage:(UIImage *)image withName:(NSString *)imageName
{
    if (![[NSFileManager defaultManager]
          fileExistsAtPath:[[self directoryPath] stringByAppendingPathComponent:imageName]])
    {
        NSData * imageData = UIImagePNGRepresentation(image);
        NSURL *fullPath = [[self directoryURL] URLByAppendingPathComponent:imageName];
        if ([imageData writeToURL:fullPath atomically:YES]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NEW_IMAGE_SAVED object:nil];
        }
    }
}

-(NSMutableArray *)loadSavedFiles
{
    NSArray *directoryContent = [[NSFileManager defaultManager]
                                 contentsOfDirectoryAtURL:[NSURL URLWithString:[self directoryPath]]
                                 includingPropertiesForKeys:@[]
                                 options:NSDirectoryEnumerationSkipsHiddenFiles
                                 error:nil];
    NSPredicate * fltr = [NSPredicate predicateWithFormat:@"pathExtension='png'"];
    NSArray * onlyPNGs = [directoryContent filteredArrayUsingPredicate:fltr];
    NSMutableArray *filePaths = [NSMutableArray new];
    [onlyPNGs enumerateObjectsUsingBlock:^(NSURL *obj, NSUInteger idx, BOOL *stop) {
        [filePaths addObject:obj];
    }];
    
    return filePaths;
}

#pragma mark - Getter

- (StudentsHolder *)studentHolder
{
    if (!_studentHolder) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Students" ofType:@"plist"];
        _studentHolder = [[JsonMapper studentsMapper] parseDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
    }
    return _studentHolder;
}



@end
