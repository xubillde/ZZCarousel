# ZZCarousel

功能支持:
1. 无限滚动轮播 
2. 支持SDWebImage加载图片 
3. 自定义添加轮播视图控件
4. 轮播点击方法
5. 奉献一轮AFNetWorking封装

使用方法:
ZZCarouselControl *carouselView = [[ZZCarouselControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3)];
carouselView.carouseScrollTimeInterval = 2.0f;
carouselView.dataSource = self;
carouselView.delegate = self;
[self.view addSubview:carouselView];

实现协议

#pragma mark --- dataSource
- (NSArray *) zzcarousel:(ZZCarouselControl *)carouselView;
- (UIView *) zzcarousel:(ZZCarouselControl *)carouselView carouselFrame:(CGRect)frame data:(NSArray *)data viewForItemAtIndex:(NSInteger)index;

#pragma mark --- delegate
-(void)zzcarouselView:(ZZCarouselControl *)zzcarouselView didSelectItemAtIndex:(NSInteger)index;

详细使用还见demo

** 联系方式

*** 关注微博：Coder__Z *** QQ群号：161389554 本人为群主

各位下载过的Coder，如果觉得这个开源还不错的话，那就劳驾给个star。感激不尽。

追赶大牛的路途中…..