//
//  ViewController.m
//  YTSegmentDemo
//
//  Created by TonyAng on 2018/4/25.
//  Copyright © 2018年 TonyAng. All rights reserved.
//

#import "ViewController.h"
#import "MLMSegmentManager.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif



@interface ViewController ()
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"YTSegmentDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    [self segmentStyle];
}

#pragma mark - 数据源
- (NSArray *)vcArr:(NSInteger)count {
    NSMutableArray *arr = [NSMutableArray array];
    OneViewController *oneViewC = [OneViewController new];
    [arr addObject:oneViewC];
    
    TwoViewController *twoViewC = [TwoViewController new];
    [arr addObject:twoViewC];

    ThreeViewController *threeViewC = [ThreeViewController new];
    [arr addObject:threeViewC];
    return arr;
}

#pragma mark - 均分下划线
- (void)segmentStyle{
    self.list = @[@"未使用",
                  @"已使用",
                   @"已过期"
                  ];
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, (65)) titles:self.list headStyle:SegmentHeadStyleSlide layoutStyle:MLMSegmentLayoutDefault];
//    _segHead.fontScale = 1.05;
    _segHead.fontSize = (16);
    /**
     *  导航条的背景颜色
     */
    _segHead.headColor = [UIColor whiteColor];

    /*------------滑块风格------------*/
    /**
     *  滑块的颜色
     */
    _segHead.slideColor = [UIColor clearColor];

    /*------------下划线风格------------*/
    /**
     *  下划线的颜色
     */
//    _segHead.lineColor = [UIColor redColor];
    /**
     *  选中颜色
     */
    _segHead.selectColor = [UIColor whiteColor];
    /**
     *  未选中颜色
     */
    _segHead.deSelectColor = [UIColor blackColor];
    /**
     *  下划线高度
     */
//    _segHead.lineHeight = 2;
    /**
     *  下划线相对于正常状态下的百分比，默认为1
     */
//    _segHead.lineScale = 0.8;
    
    /**
     *  顶部导航栏下方的边线
     */
    _segHead.bottomLineHeight = 0.5;
    _segHead.bottomLineColor = [UIColor lightGrayColor];
    /**
     *  设置当前屏幕最多显示的按钮数,只有在默认布局样式 - MLMSegmentLayoutDefault 下使用
     */
    //_segHead.maxTitles = 5;
    
    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(_segHead.frame)) vcOrViews:[self vcArr:self.list.count]];
    _segScroll.loadAll = NO;
    _segScroll.showIndex = 0;
    @weakify(self)
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        @strongify(self)
        [self.view addSubview:self.segHead];
        [self.view addSubview:self.segScroll];
    } selectEnd:^(NSInteger index) {
        if (index == 2) {
            
        }else{
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
