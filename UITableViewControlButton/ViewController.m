//
//  ViewController.m
//  UITableViewControlButton
//
//  Created by Oneofai on 15/05/2015.
//  Copyright © 2015 oneofai. All rights reserved.
//

#define SCREEN [UIScreen mainScreen].bounds.size

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *mutArray;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, assign) CGFloat offsetY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomButton.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height - 50, 50, 50);
    [self.bottomButton setBackgroundImage:[UIImage imageNamed:@"bottom"] forState:UIControlStateNormal];
    [self.view addSubview:self.bottomButton];
    
    NSURL *url = [NSURL URLWithString:@"https://ww3.sinaimg.cn/large/006tNc79ly1fedpmui3wej30500500su.jpg"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    [self.bottomButton  setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
}

- (void)actionClick:(UIButton *)button
{
    NSArray *array = [NSArray arrayWithObjects:@"1", nil];
    NSString *string = [array objectAtIndex:2];
    NSLog(@"%@",string);
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //判断滑动到底部
    if (scrollView.contentOffset.y == scrollView.contentSize.height - self.tableView.frame.size.height) {
        [UIView transitionWithView:self.bottomButton duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            self.bottomButton.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height - 50, 50, 50);
        } completion:NULL];
    }
    
    if (scrollView.contentOffset.y > self.offsetY && scrollView.contentOffset.y > 0) {//如果当前位移大于缓存位移，说明scrollView向上滑动
        [UIView transitionWithView:self.bottomButton duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            self.bottomButton.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height, 50, 50);
        } completion:NULL];
    }else if (scrollView.contentOffset.y < self.offsetY){
        [UIView transitionWithView:self.bottomButton duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            self.bottomButton.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height - 50, 50, 50);
        } completion:NULL];
    }
    self.offsetY = scrollView.contentOffset.y;//将当前位移变成缓存位移
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellUserSelect";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"test";
    return cell;
}

#pragma mark UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


@end
