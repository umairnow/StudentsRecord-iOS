//
//  AlbumVC.m
//  StudentsRecord
//
//  Created by Umair Aamir on 25/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "AlbumVC.h"

@interface AlbumVC ()

@property (strong, nonatomic) NSMutableArray *filePaths;

@end

@implementation AlbumVC

static NSInteger const ImageTag = 101;

#pragma mark - Load Menu

+ (UINavigationController *)loadAlbumVC
{
    static UINavigationController *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[UIStoryboard storyboardAlbum] instantiateInitialViewController];
    });
    return _sharedInstance;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAppearance];
    [self addObserves];
    [self loadImages];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Helping Methods

- (void)setupAppearance
{
    [self addMenuButton];
}

- (void)addObserves
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImages) name:NEW_IMAGE_SAVED object:nil];
}

- (void)loadImages
{
    dispatch_async(dispatch_queue_create("imageLoadQueue", NULL), ^{
            self.filePaths = [utility loadSavedFiles];
        dispatch_async(dispatch_get_main_queue(), ^{
           [albumCollectionView reloadData];
        });
    });
}

- (void)cameraAction
{
    @try {
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        if (status == ALAuthorizationStatusAuthorized || status == ALAuthorizationStatusNotDetermined) {
            UIImagePickerController *imagePickController = [[UIImagePickerController alloc] init];
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                imagePickController.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePickController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePickController.sourceType];
            } else {
                [utility showErrorMessageBarWithTitle:@"Error" andMessage:@"Device has no camera"];
                return;
            }
            imagePickController.delegate = self;
            imagePickController.allowsEditing = YES;
            [self presentViewController:imagePickController animated:YES completion:nil];
        } else {
            [utility showErrorMessageBarWithTitle:ACCESS_PERMISSION_TITLE andMessage:IMAGE_PERMISSION_MESSAGE];
        }
    }
    @catch (NSException *exception) {
        DLog(@"Open Image Error: %@", exception.debugDescription);
    }
}

#pragma mark - UICollectionView Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.filePaths.count+1; //+1 for Camera
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    if (indexPath.item > 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExistingPicture" forIndexPath:indexPath];
        NSData *data = [NSData dataWithContentsOfURL:self.filePaths[indexPath.row -1]];
        [(UIImageView *)[cell viewWithTag:ImageTag] setImage:[UIImage imageWithData:data]];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TakePicture" forIndexPath:indexPath];
    }
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.borderWidth = 1.0;
    cell.layer.cornerRadius = 5.0;
    return cell;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self cameraAction];
        return;
    }
}

#pragma mark - Image Picker Controller Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    dispatch_async(dispatch_queue_create("saveImage", NULL), ^{
        [utility saveImage:editedImage withName:[NSString stringWithFormat:@"images-%u.png", arc4random()]];
    });
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
