//
//  ZZCarouselControl.m
//  ZZCarousel
//
//  Created by Yuan on 16/2/15.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ZZCarouselControl.h"

@interface ZZCarouselControl()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *coreView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ZZCarouselControl

#pragma mark --- 懒加载数据数组
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void) makeCoreUI:(CGRect)frame
{
    self.coreView = [[UIScrollView alloc]initWithFrame:frame];
    self.coreView.showsHorizontalScrollIndicator = NO;
    self.coreView.delegate = self;
    [self addSubview:self.coreView];
}

-(void) makePageUI:(CGRect)frame
{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor greenColor];
    [self addSubview:_pageControl];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self makeCoreUI:frame];
        [self makePageUI:frame];
        
    }
    return self;
}

-(void)reloadData
{
    NSArray *data = nil;
    if ([self.dataSource respondsToSelector:@selector(zzcarousel:)]) {
        data = [self.dataSource zzcarousel:self];
    }
    
    id firstImage = data.firstObject;
    id lastImage = data.lastObject;
    [self.dataArray addObject:lastImage];
    [self.dataArray addObjectsFromArray:data];
    [self.dataArray addObject:firstImage];
    
    
    [self reloadCoreUI:self.dataArray];
    
}

-(void) reloadCoreUI:(NSMutableArray *)dataArray
{
    if (dataArray.count != 0) {
        
        for (int i = 0; i < dataArray.count; i++) {
            
            CGFloat imageW = self.frame.size.width;
            CGFloat imageH = self.frame.size.height;
            CGFloat imageY = 0;
            CGFloat imageX = i * self.frame.size.width;
            CGRect frame = CGRectMake(imageX, imageY, imageW, imageH);
            
            UIView *realView = [self.dataSource zzcarousel:self carouselFrame:frame data:dataArray viewForItemAtIndex:i];
            realView.tag = i + 100;
            [self.coreView addSubview:realView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapped:)];
            [realView addGestureRecognizer:tap];
            
            
        }
        
        //设置轮播器的滚动范围
        self.coreView.contentSize = CGSizeMake(dataArray.count * self.frame.size.width, 0);
        self.coreView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        
        //打开分页功能
        self.coreView.pagingEnabled = YES;
        //设置分页的页数
        self.pageControl.numberOfPages = dataArray.count - 2;
        
        
        //添加定时器
        [self createTimer];
    }
    
}

/*
 *  创建定时器
 */

- (void)createTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_carouseScrollTimeInterval target:self selector:@selector(autoCarouselScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/*
 * 执行定时器方法
 */

- (void)autoCarouselScroll
{
    CGFloat offsetX;
    NSInteger result = (int)self.coreView.contentOffset.x % (int)self.bounds.size.width;
    NSInteger positionNum = (int)self.coreView.contentOffset.x / (int)self.bounds.size.width;
    if (result != 0) {
        offsetX = self.bounds.size.width * positionNum + self.bounds.size.width;
    }else
    {
        offsetX = self.coreView.contentOffset.x + self.bounds.size.width;
    }
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.coreView setContentOffset:offset animated:YES];
    
}

-(void)Tapped:(UIGestureRecognizer *) gesture
{
    
    NSInteger index = gesture.view.tag-101;
    
    if ([self.delegate respondsToSelector:@selector(zzcarouselView:didSelectItemAtIndex:)]) {
        [self.delegate zzcarouselView:self didSelectItemAtIndex:index];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    int page = (self.coreView.contentOffset.x + self.bounds.size.width * 0.5) / self.bounds.size.width - 1;
    self.pageControl.currentPage = page;
    if (self.coreView.contentOffset.x > self.bounds.size.width * (self.dataArray.count - 1.5)) {
        self.pageControl.currentPage = 0;
    }else if (self.coreView.contentOffset.x < self.bounds.size.width * 0.5)
    {
        self.pageControl.currentPage = self.dataArray.count - 3;
    }
    
    if (self.coreView.contentOffset.x <= 0) {
        self.coreView.contentOffset = CGPointMake(self.bounds.size.width * (self.dataArray.count - 2), 0);
    }else if (self.coreView.contentOffset.x >= self.bounds.size.width * (self.dataArray.count - 1))
    {
        self.coreView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self createTimer];
}



@end
