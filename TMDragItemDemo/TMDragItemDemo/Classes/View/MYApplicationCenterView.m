//
//  MYApplicationCenterView.m
//  MYShengYiJia
//
//  Created by weibo on 17/1/14.
//  Copyright © 2017年 MYun. All rights reserved.
//

#import "MYApplicationCenterView.h"
#import "MYApplicationCenterModel.h"
#import "MYBaseViewController.h"
#import "MYAppItemView.h"
#import "AppConfig.h"

@interface MYApplicationCenterView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *sortLabel;
@property (weak, nonatomic) IBOutlet UILabel *unAddLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *addCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *addCollectionViewLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addCollectionViewHC;
@property (weak, nonatomic) IBOutlet UICollectionView *unAddCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *unAddCollectionViewLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *unAddCollectionViewHC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHC;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGr;
@property (strong, nonatomic) NSMutableArray *addAppArr;
@property (strong, nonatomic) NSMutableArray *unAddAppArr;
@property (assign, nonatomic) CGFloat itemW;
@property (assign, nonatomic) CGFloat itemH;
@property (assign, nonatomic) BOOL isEditMode;

@end

@implementation MYApplicationCenterView
static NSString *const identifier = @"MYApplicationCenterViewCell";
static CGFloat Row = 4;
static CGFloat Ratio = 1.7;
static CGFloat MarginX = 7;
typedef NS_ENUM(NSInteger,CollectionVTag) {
    AddCollectionVTag = 1,
    UnAddCollectionVTag = 2,
};

#pragma mark – dealoc

#pragma mark - init method

- (void)awakeFromNib{
    [self initView];
}

- (void)initView{
    self.sortLabel.hidden = YES;
    
    [self setupCollectionView];
}

#pragma mark – netdata
- (void)updateNetData{
    WeakObj(self);

    if (__DEMO_MODE__) {
        //测试
        [MBHUDView showWait:@"加载中"];
        dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(timer, dispatch_get_main_queue(), ^{
            
            [MBHUDView dismissCurrentHUD];

            [selfWeak.addAppArr removeAllObjects];
            [selfWeak.unAddAppArr removeAllObjects];
            
            NSMutableArray *addAppList = [NSMutableArray array];
            NSMutableArray *unAddAppList = [NSMutableArray array];

            int i = 0;
            for (i = 0; i < 5; i++) {
                MYApplicationCenterModel *model = [[MYApplicationCenterModel alloc] init];
                model.ModuleName = [NSString stringWithFormat:@"应用%d",i];
                model.ModuleCode = @(i);
                model.IsAvailable = @1;
                model.SortIndex = @(i);
                [addAppList addObject:model];
            }
            
            for (int j = 0; j < 4; j++) {
                MYApplicationCenterModel *model = [[MYApplicationCenterModel alloc] init];
                model.ModuleName = [NSString stringWithFormat:@"应用%d",i+j];
                model.ModuleCode = @(i+j);
                model.IsAvailable = @1;
                model.SortIndex = @(j);
                [unAddAppList addObject:model];
            }
            
            [selfWeak dataListSortWithArr1:addAppList arr2:unAddAppList];
         
        });

    }else{
        //真实
//        NSDictionary *paramDict = @{
//                                    @"UId":[[MYAccount sharedAccount] uId],
//                                    @"CId":[[MYAccount sharedAccount] cId],
//                                    };
//        [self.dataHandle requestAppCenterListWithDict:paramDict completion:^(BOOL isSuccess) {
//            
//            [selfWeak dataListSortWithArr1:selfWeak.dataHandle.addAppList arr2:selfWeak.dataHandle.unAddAppList];
//            
//        }];

    }
    
}

/*
 * 保存修改
 */
- (void)saveAppListModify{
    
    NSMutableArray *addCodeArr = [NSMutableArray array];
    for (MYApplicationCenterModel *model in self.addAppArr) {
        [addCodeArr addObject:model.ModuleCode];
    }
    NSMutableArray *unAddCodeArr = [NSMutableArray array];
    for (MYApplicationCenterModel *model in self.unAddAppArr) {
        [unAddCodeArr addObject:model.ModuleCode];
    }
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    paramDict[@"IsAddArray"] = addCodeArr;
    paramDict[@"NotAddArray"] = unAddCodeArr;

}

#pragma mark - public method

#pragma mark - private method
//数据排序
- (void)dataListSortWithArr1:(NSMutableArray *)arr1 arr2:(NSMutableArray *)arr2{
    
    //对已添加应用数组进行排序
    [self.addAppArr removeAllObjects];
    _addAppArr = [NSMutableArray arrayWithArray:[self arrSort:arr1]];
    
    //对未添加应用数组进行排序
    [self.unAddAppArr removeAllObjects];
    _unAddAppArr = [NSMutableArray arrayWithArray:[self arrSort:arr2]];
    
    //刷新页面
    [self updateCollectionViewFrame];
    [self.addCollectionView reloadData];
    [self.unAddCollectionView reloadData];
}

//数组排序
- (NSArray *)arrSort:(NSMutableArray *)srcArr{
    NSArray *result = [srcArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        MYApplicationCenterModel *model1 = (MYApplicationCenterModel *)obj1;
        MYApplicationCenterModel *model2 = (MYApplicationCenterModel *)obj2;
        return [model1.SortIndex compare:model2.SortIndex]; //升序
        
    }];
    
    return result;
}

- (void)setupCollectionView{
    
    self.addCollectionView.delegate = self;
    self.addCollectionView.dataSource = self;
    self.addCollectionView.tag = AddCollectionVTag;
    
    self.unAddCollectionView.delegate = self;
    self.unAddCollectionView.dataSource = self;
    self.unAddCollectionView.tag = UnAddCollectionVTag;
    
    self.addCollectionView.backgroundColor = [UIColor clearColor];
    self.unAddCollectionView.backgroundColor = [UIColor clearColor];
    
    self.addCollectionView.clipsToBounds = NO;
    self.unAddCollectionView.clipsToBounds = NO;
    
    [self.addCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [self.unAddCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    CGFloat marginX = MarginX;
    //    NSInteger row = (__kScreenHeight == 568 || __kScreenHeight == 480) ? 3 : 4;
    NSInteger row = Row;
    CGFloat itemW = (__kScreenWidth - 34 - (row - 1) * marginX) / row;
    CGFloat itemH = itemW;//itemW/Ratio;
    _itemW = itemW;
    _itemH = itemH;
    
    self.addCollectionViewLayout.itemSize = CGSizeMake(itemW, itemH);
    self.unAddCollectionViewLayout.itemSize = CGSizeMake(itemW, itemH);
    self.addCollectionViewLayout.minimumInteritemSpacing = 0;
    self.unAddCollectionViewLayout.minimumInteritemSpacing = 0;
    
//    self.sortLabel.hidden = YES;
//    self.unAddLabel.hidden = YES;
}

- (void)updateCollectionViewFrame{
    
    //隐藏标题
//    self.sortLabel.hidden = !(_addAppArr.count > 0);
//    self.unAddLabel.hidden = !(_unAddAppArr.count > 0);
    
    //    if (self.addAppArr.count == 0 || self.unAddAppArr.count == 0) return;
    //    NSInteger row = (__kScreenHeight == 568 || __kScreenHeight == 480) ? 3 : 4;
    NSInteger row = Row;
    
    NSInteger upAddNum = self.addAppArr.count % row == 0 ? 0 : 1;
    NSInteger downAddNum = self.unAddAppArr.count % row == 0 ? 0 : 1;
    
    NSInteger upRowNum = self.addAppArr.count / row + upAddNum;
    NSInteger downRowNum = self.unAddAppArr.count / row + downAddNum;
    
    self.addCollectionViewHC.constant = upRowNum * _itemH + (upRowNum - 1) * 10;
    self.unAddCollectionViewHC.constant = downRowNum * _itemH + (downRowNum - 1) * 10;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.contentViewHC.constant = CGRectGetMaxY(self.unAddCollectionView.frame) + 10;
    });
}

#pragma mark - 交互方法

// 编辑或者完成按钮被点击
- (void)editOrFinishBtnClicked:(UIButton *)sender{
    UIButton *btn = sender;
    btn.selected = !btn.isSelected;
    _isEditMode = btn.selected;
    if (btn.selected) {
        [self switchToEditState];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        [self switchToDefaultState];
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        //保存修改
        [self saveAppListModify];
    }
}

// 点击编辑按钮，切换到编辑状态
- (void)switchToEditState{
    
    //    self.unAddCollectionView.hidden = YES;
    //    self.unAddLabel.hidden = YES;
    
    self.sortLabel.hidden = NO;
    
    [self.addCollectionView reloadData];
    [self.addCollectionView addGestureRecognizer:self.longPressGr];
    [self.unAddCollectionView reloadData];
}

// 点击完成按钮，切换到默认状态
- (void)switchToDefaultState{
    
    self.unAddCollectionView.hidden = NO;
    self.unAddLabel.hidden = NO;
    self.sortLabel.hidden = YES;
    
    //    self.addCollectionView.tag = 0;
    [self.addCollectionView reloadData];
    [self.unAddCollectionView reloadData];
    
    [self.addCollectionView removeGestureRecognizer:self.longPressGr];
}

////  退出按钮被点击
//- (IBAction)exitButtonClicked {
//
//    [UIView animateWithDuration:0.25 animations:^{
//        self.transform = CGAffineTransformMakeTranslation(0, - self.bounds.size.height);
//
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
//
////    !self.completionBlock ?: self.completionBlock(self.upCricles);
//}

#pragma mark - 长按手势相关

- (UILongPressGestureRecognizer *)longPressGr{
    if (_longPressGr == nil) {
        _longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandle:)];
        _longPressGr.minimumPressDuration = 0.5;
        _longPressGr.delaysTouchesBegan = YES;
    }
    return _longPressGr;
}

- (void)longPressHandle:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    if (SYSTEM_VERSION_LESS_THAN(@"9.0")) {
        [self longPressToDo2:gestureRecognizer];
    } else {
        [self longPressToDo:gestureRecognizer];
    }
    
}

// 长按手势动作，ios9以下
-(void)longPressToDo2:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    static NSIndexPath *startIndexPath = nil;
    
    switch (gestureRecognizer.state) {
            
        case UIGestureRecognizerStateBegan: // 长按手势刚开始
        {
            CGPoint startP = [gestureRecognizer locationInView:self.addCollectionView];
            
            startIndexPath = [self.addCollectionView indexPathForItemAtPoint:startP];
            
            if (startIndexPath == nil) return;
            
            UICollectionViewCell* startCell = [self.addCollectionView cellForItemAtIndexPath:startIndexPath];
            
            startCell.transform = CGAffineTransformMakeScale(1.2, 1.2);
            
            [self.addCollectionView bringSubviewToFront:startCell];
        }
            break;
            
        case UIGestureRecognizerStateChanged: // 长按手势移动过程中
        {
            if (startIndexPath == nil) return;
            
            CGPoint changeP = [gestureRecognizer locationInView:self.addCollectionView];
            NSIndexPath *changeIndexPath = [self.addCollectionView indexPathForItemAtPoint:changeP];
            
            if (changeIndexPath == nil || changeIndexPath.item == startIndexPath.item) return;
            
            //1.设置位置
            UICollectionViewCell *moveCell = [self.addCollectionView cellForItemAtIndexPath:startIndexPath];
            moveCell.center = changeP;
            //2.改变数据源（reload时重新排序）
            NSString *startModel = self.addAppArr[startIndexPath.item];
            [self.addAppArr removeObject:startModel];
            [self.addAppArr insertObject:startModel atIndex:changeIndexPath.item];
            
            [self.addCollectionView moveItemAtIndexPath:startIndexPath toIndexPath:changeIndexPath];
            
            startIndexPath = changeIndexPath;
        }
            break;
            
        case UIGestureRecognizerStateEnded: // 长按手势结束
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.addCollectionView reloadData];
            });
        }
            break;
            
        default:
            break;
    }
    
}



// 长按手势动作,iOS9以上
-(void)longPressToDo:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    //获取此次点击的坐标，根据坐标获取cell对应的indexPath
    CGPoint point = [gestureRecognizer locationInView:self.addCollectionView];
    NSIndexPath *indexPath = [self.addCollectionView indexPathForItemAtPoint:point];
    
    switch (gestureRecognizer.state) {
            
        case UIGestureRecognizerStateBegan: // 长按手势刚开始
        {
            if (!indexPath) return;
            UICollectionViewCell* startCell = [self.addCollectionView cellForItemAtIndexPath:indexPath];
            startCell.transform = CGAffineTransformMakeScale(1.2, 1.2); //放大
            [self.addCollectionView bringSubviewToFront:startCell];
            //开始移动
            [self.addCollectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            
        }
            break;
            
        case UIGestureRecognizerStateChanged: // 长按手势移动过程中
        {
            if (!indexPath) return;
            //移动过程中更新位置坐标
            [self.addCollectionView updateInteractiveMovementTargetPosition:point];
            
        }
            break;
            
        case UIGestureRecognizerStateEnded: // 长按手势结束
        {
            //停止移动调用此方法
            [self.addCollectionView endInteractiveMovement];
            
        }
            break;
            
        default:{
            //取消移动
            [self.addCollectionView cancelInteractiveMovement];
            
        }
            break;
    }
}

// 在开始移动时会调用此代理方法，
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    //根据indexpath判断单元格是否可以移动，如果都可以移动，直接就返回YES ,不能移动的返回NO
    if (collectionView.tag == AddCollectionVTag && self.isEditMode) {
        return YES;
    }
    return NO;
}

// 在移动结束的时候调用此代理方法
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    /**
     *sourceIndexPath 原始数据 indexpath
     * destinationIndexPath 移动到目标数据的 indexPath
     */
    
    MYApplicationCenterModel *startModel = self.addAppArr[sourceIndexPath.row];
    [self.addAppArr removeObject:startModel];
    [self.addAppArr insertObject:startModel atIndex:destinationIndexPath.row];
}

#pragma mark - UICollectionView代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger num = 0;
    if (collectionView.tag == AddCollectionVTag) {
        num = self.addAppArr.count;
    }else{
        num = self.unAddAppArr.count;
    }
    return num;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    MYApplicationCenterModel *model;
    if (collectionView.tag == AddCollectionVTag) {
        model = self.addAppArr[indexPath.item];
    }else{
        model = self.unAddAppArr[indexPath.item];
    }
    
    //    // 上面的应用，且是处于可编辑状态
    //    BOOL edited = collectionView == self.addCollectionView && self.upCollectionViewIsEdited;
    
    cell.backgroundView = [self circleCellWithCircleModel:model collectionView:collectionView UICollectionViewCell:cell edited:_isEditMode];
    
    //    cell.backgroundView = [self circleCellWithCircleModel:model collectionView:collectionView edited:_isEditMode];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.addCollectionView) {// 上面应用item被点击
        
        MYApplicationCenterModel *model = self.addAppArr[indexPath.item];
        
        if (self.isEditMode) {// 处于编辑状态，点击删除，应用移动到下面去
            
            [self.addAppArr removeObject:model];
            [self.unAddAppArr addObject:model];
            
            [self updateCollectionViewFrame];
            
            [self.unAddCollectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.unAddAppArr.count - 1 inSection:0]]];
            [self.addCollectionView deleteItemsAtIndexPaths:@[indexPath]];
            
        }else{// 处于普通状态，点击跳到首页相对应的应用
            
            [self go2AppDetailWithIndexPath:indexPath];
        }
        
    }else{
        
        if (self.isEditMode) {// 下面应用item被点击后移动到上面去
            MYApplicationCenterModel *model = self.unAddAppArr[indexPath.item];
            [self.unAddAppArr removeObject:model];
            [self.addAppArr addObject:model];
            
            [self updateCollectionViewFrame];
            
            [self.addCollectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.addAppArr.count - 1 inSection:0]]];
            [self.unAddCollectionView deleteItemsAtIndexPaths:@[indexPath]];

        }
    }
}

- (void)go2AppDetailWithIndexPath:(NSIndexPath *)indexPath{
    
    MYApplicationCenterModel *model = self.addAppArr[indexPath.item];
    switch ([model.ModuleCode integerValue]) {
        case 0:{
           
        }
            break;
        case 1:{
            
        }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            
        }
            break;
        case 4:{
            
        }
            break;
        case 5:{
            
        }
            break;
    
        default:
            break;
    }
}

- (UIView *)circleCellWithCircleModel:(MYApplicationCenterModel *)model collectionView:(UICollectionView *)collectionView UICollectionViewCell:(UICollectionViewCell *)cell edited:(BOOL)edited{
    
    MYAppItemView *itemView = [[MYAppItemView alloc] initWithFrame:CGRectMake(0, 0, _itemW, _itemH)];
    itemView.name.text = model.ModuleName;
    
    if (edited) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        if (collectionView == self.addCollectionView) {
            imageV.image = [UIImage imageNamed:@"deleteBtn"];
        }else{
            imageV.image = [UIImage imageNamed:@"addBtn"];
        }
        
        CGFloat iW = 12;
        imageV.frame = CGRectMake(_itemW - iW*1.3, iW*0.3, iW, iW);
        [itemView addSubview:imageV];
        
    }
    return itemView;
}

#pragma mark – otherDelegate

#pragma mark - getters and setter
- (NSMutableArray *)addAppArr{
    if (!_addAppArr) {
        _addAppArr = [NSMutableArray array];
    }
    return _addAppArr;
}

- (NSMutableArray *)unAddAppArr{
    if (!_unAddAppArr) {
        _unAddAppArr = [NSMutableArray array];
    }
    return _unAddAppArr;
}

@end
