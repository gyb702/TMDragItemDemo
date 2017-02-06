//
//  MYApplicationCenterVC.m
//  MYShengYiJia
//
//  Created by weibo on 17/1/14.
//  Copyright © 2017年 MYun. All rights reserved.
//

#import "MYApplicationCenterVC.h"
#import "MYApplicationCenterView.h"


@interface MYApplicationCenterVC ()
@property (strong, nonatomic) MYApplicationCenterView *appCenterView;
@end

@implementation MYApplicationCenterVC
#pragma mark – dealoc
- (void)dealloc{
  
    
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.appCenterView updateNetData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init method
- (void)initNavigationBar{
    [super initNavigationBar];
    
    self.navigationItem.title = @"应用中心";
    
    //返回
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(0, 0, 60, 30);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:editBtn];
}

- (void)initUI{
    [super initUI];
    
    //    appCenterView.addAppArr = existCircles.mutableCopy;
//    appCenterView.completionBlock = block;
//    [appCenterView updateCollectionViewFrame];
    [self.view addSubview:self.appCenterView];
}

#pragma mark – netdata

#pragma mark - private method
- (void)editBtnClicked:(id)sender{
    [self.appCenterView editOrFinishBtnClicked:sender];
}

#pragma mark - public method

#pragma mark – otherDelegate

#pragma mark - getters and setter
- (MYApplicationCenterView *)appCenterView{
    if (!_appCenterView) {
        _appCenterView = [[[NSBundle mainBundle] loadNibNamed:@"MYApplicationCenterView" owner:self options:nil] lastObject];
        _appCenterView.frame = CGRectMake(0, 0, __kScreenWidth, __kScreenHeight - NavigationBarHeight);//self.view.bounds;
    }
    return _appCenterView;
}
@end
