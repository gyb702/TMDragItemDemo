//
//  MYBaseViewController.h
//  MYAppBaseFrame
//
//  Created by weibo on 16/9/2.
//  Copyright © 2015年 MYun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConfig.h"

@protocol MYBaseTableViewDelegate <NSObject>

@optional
- (void)tableView:(UITableView *)tableView cellClickedWithIndexPath:(NSIndexPath *)indexPath selectedModel:(id)model;
- (void)tableView:(UITableView *)tableView cellClickedWithBtn:(id)sender indexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView cellClickedWithModel:(id)model indexPath:(NSIndexPath *)indexPath;
@end

@interface MYBaseViewController : UIViewController

@property (nonatomic,weak)id<MYBaseTableViewDelegate>   tvDelegate;

/**
 *  self.view.frame.size
 */
@property (assign, nonatomic) CGSize size;

@property (strong, nonatomic) UIButton *backBtn;

- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;

- (void)initNavigationBar;
- (void)initUI;

- (instancetype)init;

- (void)back;

@end
