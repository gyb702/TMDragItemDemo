//
//  MYBaseViewController.m
//  MYAppBaseFrame
//
//  Created by weibo on 16/9/2.
//  Copyright © 2015年 MYun. All rights reserved.
//*******视图控制器基类***********

#import "MYBaseViewController.h"
#import "AppDelegate.h"

@interface MYBaseViewController ()

@end

@implementation MYBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (void)dealloc{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)initNavigationBar{
    //配置全局返回按钮
    UIImage *backImage = [UIImage imageNamed:@"backW"];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[backImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backImage.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-__kScreenWidth, -60) forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundColor:__kMYRedColor];
    [self.navigationController.navigationBar setBarTintColor:__kMYRedColor];
    
    [self.navigationController.navigationBar setTintColor:__kColorWithRHedix(0xF7941E)];
    
    //判断是否需要有返回按钮
    NSArray *arrViewControllers = self.navigationController.viewControllers;
    if ([arrViewControllers indexOfObject:self] > 0) {
        //返回
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 30, 30);
        [backBtn setImage:[UIImage imageNamed:@"backW"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        //按钮靠左
        UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        nagetiveSpacer.width = -15;//根据自己需要自己调整
        self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, self.navigationItem.leftBarButtonItem];
        _backBtn = backBtn;
    }
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
    self.view.backgroundColor = __kDefaultBackgroundGrayColor;
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.autoresizesSubviews = NO;
}

- (void)maskViewPressed:(id)sender{
    [self.view endEditing:YES];
}

- (CGSize)size{
    return self.view.frame.size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
//    [MBHUDView showError:@"占用内存过高,已为您清理缓存."];
    
    //清理webview缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
