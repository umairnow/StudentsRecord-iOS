//
//  MenuVC.m
//  StudentsRecord
//
//  Created by Umair Aamir on 25/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "MenuVC.h"

@interface MenuVC ()
@property (nonatomic, strong) NSArray *arrMenu;

@end

@implementation MenuVC

static NSString * const CellIdentifier = @"MenuCellIdentifier";

#pragma mark - Load Menu

+ (MenuVC *)loadMenuVC
{
    static MenuVC *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[UIStoryboard storyboardMenu] instantiateViewControllerWithIdentifier:@"MenuVC"];
    });
    return _sharedInstance;
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeVariables];
    [self loadMenus];
}

- (void)dealloc
{
    self.arrMenu = nil;
}

#pragma mark - Helping Methods

- (void)initializeVariables
{
    self.arrMenu = @[[AlbumVC loadAlbumVC], [GradesVC loadGradesVC], [LocationMapVC loadLocationMapVC]];
}

- (void)loadMenus
{
    [tvMenu reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrMenu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UIViewController *vc = self.arrMenu[indexPath.row];
    cell.textLabel.text = vc.title;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.sideMenuViewController setContentViewController:self.arrMenu[indexPath.row] animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

@end
