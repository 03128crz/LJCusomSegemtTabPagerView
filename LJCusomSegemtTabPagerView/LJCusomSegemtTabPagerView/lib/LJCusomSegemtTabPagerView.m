//
//  LJCusomSegemtTabPagerView.m
//  LJCusomSegemtTabPagerView
//
//  Created by james on 16/1/6.
//  Copyright © 2016年 kfvnx. All rights reserved.
//

#import "LJCusomSegemtTabPagerView.h"
#import "LJCusomSegemtTabPagerCell.h"

@interface LJCusomSegemtTabPagerView ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *titlesView;
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) NSIndexPath *selectedItemIndexPath;
@property (nonatomic, strong) UIView *indicaterView;
@property (nonatomic, strong) NSMutableSet *selectedTitles;
//@property (nonatomic, strong) DefaultVCBlock block;

@end

@implementation LJCusomSegemtTabPagerView

- (instancetype)initWithFrame: (CGRect)frame {
    
    _selectedTitles = [NSMutableSet setWithCapacity:20];
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _cellHeight = 36;
        _fontSize = 15;
        _viewMarginHeight = 0;
        _titlePadding = 14;
        _indicaterViewColor = [UIColor blueColor];
        _titleColor = [UIColor blackColor];
        _titleHighlightColor = [UIColor blueColor];
        _indicaterSameWidthWithTitle = YES;
    }
    
    return self;
}

-(void)layoutSubviews {
    
    [self setupTitlesView];
    [self setupContentView];
    [self setupIndicateView];

}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LJCusomSegemtTabPagerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LJCusomSegemtTabPagerCell" forIndexPath:indexPath];
    cell.titleLabel.text = _titles[indexPath.row];
    cell.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
    if (indexPath == _selectedItemIndexPath) {
        cell.titleLabel.textColor = _titleHighlightColor;
    }else {
        cell.titleLabel.textColor = _titleColor;
    }
    return cell;
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath == _selectedItemIndexPath) {
        return;
    }
    
    if (_selectedItemIndexPath) {
        LJCusomSegemtTabPagerCell *cell = (LJCusomSegemtTabPagerCell *)[collectionView cellForItemAtIndexPath:_selectedItemIndexPath];
        cell.titleLabel.textColor = _titleColor;
    }
    
    LJCusomSegemtTabPagerCell *cell = (LJCusomSegemtTabPagerCell *)[collectionView cellForItemAtIndexPath:indexPath];
    _selectedItemIndexPath = indexPath;
    
    CGRect  frameInWindows = CGRectMake(0, 0, 0, 0);
    if (_indicaterSameWidthWithTitle == true) {
        frameInWindows = [cell convertRect:cell.titleLabel.frame toView:_titlesView];
    }else {
        frameInWindows = [cell convertRect:cell.contentView.frame toView:_titlesView];
    }
    
    [UIView animateWithDuration:.3f animations:^{
        
        CGRect size = _indicaterView.frame ;
        size.size.width = frameInWindows.size.width;
        size.origin.x = frameInWindows.origin.x;
        _indicaterView.frame = size;
        
    } completion:^(BOOL finished) {
        cell.titleLabel.textColor = _titleHighlightColor;
    }];
    
    [_titlesView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [_contentView setContentOffset:CGPointMake(indexPath.row*_contentView.frame.size.width, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if ([scrollView isKindOfClass:[_titlesView  class]]) {
        return;
    }
    
    NSInteger index = scrollView.contentOffset.x / _contentView.frame.size.width;
    
    if ([_selectedTitles containsObject:_titles[index]]) {
        return;
    }
    
    [_selectedTitles addObject:_titles[index]];
    
    if ([self.delegate respondsToSelector:@selector(pagerContentView:didSelectTitle:didSelectedIndex:)]) {
        [self.delegate pagerContentView:_contentView didSelectTitle:_titles[index] didSelectedIndex:(NSInteger)index];
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([scrollView isKindOfClass:[_titlesView  class]]) {
        return;
    }
    
    NSInteger index = scrollView.contentOffset.x / _contentView.frame.size.width;
    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
    [self collectionView:_titlesView didSelectItemAtIndexPath:path];
    [self scrollViewDidEndScrollingAnimation:scrollView];
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize labelSize = [_titles[indexPath.row] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:_fontSize]}];
    if (_titleUnitedWith) {
        return CGSizeMake(_titleUnitedWith, _cellHeight);
    }else {
        return CGSizeMake(labelSize.width+_titlePadding*2, _cellHeight);
    }
}

#pragma mark - private method
- (void)setupTitlesView {
    if (_titlesView) {
        return;
    }
    
    UICollectionViewFlowLayout *flowFayout = [[UICollectionViewFlowLayout alloc] init];
    flowFayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowFayout.minimumInteritemSpacing = 0;
    flowFayout.minimumLineSpacing = 0;
    
    _titlesView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.frame.origin.x, 0, self.frame.size.width , _cellHeight) collectionViewLayout:flowFayout];
    _titlesView.backgroundColor = [UIColor whiteColor];
    _titlesView.delegate = self;
    _titlesView.dataSource = self;
    _titlesView.showsHorizontalScrollIndicator = NO;
    [_titlesView registerNib:[UINib nibWithNibName:@"LJCusomSegemtTabPagerCell" bundle:nil] forCellWithReuseIdentifier:@"LJCusomSegemtTabPagerCell"];
    
    [self addSubview:_titlesView];
}

- (void)setupContentView {
    
    if (_contentView) {
        return;
    }
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.frame.origin.x,_cellHeight +_viewMarginHeight, self.frame.size.width, self.frame.size.height-_cellHeight-_viewMarginHeight)];
    _contentView.delegate = self ;
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.pagingEnabled = YES;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.bounces = NO;
    _contentView.contentSize = CGSizeMake(_titles.count * self.frame.size.width, self.frame.origin.x);
    
    [self addSubview:_contentView];
    
}

-(void)setupIndicateView {
    
    if (_indicaterView) {
        return;
    }
    _indicaterView = [[UIView alloc] initWithFrame:CGRectMake(0, _cellHeight - 2.0, 10, 2.0)];
    _indicaterView.backgroundColor = _indicaterViewColor;
    [self.titlesView addSubview:_indicaterView];
    
    //全部view的数据加载完毕后自动移到第一个
    [_titlesView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger initIndex = 0 ;
        NSIndexPath *path = [NSIndexPath indexPathForRow:initIndex inSection:0];
        
        [self collectionView:_titlesView didSelectItemAtIndexPath:path];
        
        if ([self.delegate respondsToSelector:@selector(pagerContentView:didSelectTitle:didSelectedIndex:)]) {
            [self.delegate pagerContentView:_contentView didSelectTitle:_titles[initIndex] didSelectedIndex:initIndex];
            [_selectedTitles addObject:_titles[initIndex]];
        }
    });
    
}

@end
