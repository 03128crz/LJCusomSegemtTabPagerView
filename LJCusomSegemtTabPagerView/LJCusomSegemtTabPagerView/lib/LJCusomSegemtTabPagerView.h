//
//  LJCusomSegemtTabPagerView.h
//  LJCusomSegemtTabPagerView
//
//  Created by james on 16/1/6.
//  Copyright © 2016年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DefaultVCBlock) (UIView *contentView ,NSString *title);

@protocol LJCusomSegemtTabPagerViewDelegate <NSObject>

@required
- (void)pagerContentView:(UIView *)view didSelectTitle:(NSString *)title ;

@end

@interface LJCusomSegemtTabPagerView : UIView

//after initWithFrame must assign this property
@property (nonatomic, strong) NSArray *titles;

//custom property
@property (nonatomic, copy) UIColor *indicaterViewColor;
@property (nonatomic, copy) UIColor *titleColor;
@property (nonatomic, copy) UIColor *titleHighlightColor;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat viewMarginHeight;
@property (nonatomic, assign) CGFloat titlePadding;
@property (nonatomic, assign) BOOL indicaterSameWidthWithTitle;
@property (nonatomic, assign) CGFloat titleUnitedWith;

@property (nonatomic, strong) id<LJCusomSegemtTabPagerViewDelegate> delegate;

- (instancetype)initWithFrame: (CGRect)frame;

// ViewDidAppear中依次调用以下两个方法
- (void) addDefaultVCWithBlock: (DefaultVCBlock) block;
- (void)defaultTitleClick;

@end
