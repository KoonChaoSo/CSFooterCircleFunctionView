//
//  ViewController.m
//  CSFooterCircleFunctionView
//
//  Created by 苏冠超[产品技术中心] on 2018/8/27.
//  Copyright © 2018年 苏冠超[产品技术中心]. All rights reserved.
//

#import "ViewController.h"
#import "CSFooterCircleFunctionView.h"
#import "CSFotterCircleScrollToTopSubview.h"
#import "CSFotterCircleShowSrcollIndexTypeSubview.h"
#import "CSFooterCircleSubviewProtocol.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CSFooterCircleFunctionView *footerCircleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.footerCircleView setFrame:CGRectMake(self.view.bounds.size.width - 70, self.view.bounds.size.height - 100, 50, 50)];
    [self.view addSubview:self.footerCircleView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test1"];
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row]];
    [cell setBackgroundColor:[UIColor brownColor]];
    return cell;
}

- (NSArray<CSFooterCircleSubviewProtocol> *)setupSubViewsForFooterCircleFunctionView
{
    CSFotterCircleScrollToTopSubview *scrollToTopSubViews = [[CSFotterCircleScrollToTopSubview alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [scrollToTopSubViews setHighlighted:NO];
    
    CSFotterCircleShowSrcollIndexTypeSubview *srcollIndexTypeSubview = [[CSFotterCircleShowSrcollIndexTypeSubview alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [scrollToTopSubViews setHighlighted:NO];
    
    return @[scrollToTopSubViews,srcollIndexTypeSubview];
}


- (CSFooterCircleFunctionView *)footerCircleView
{
    if (!_footerCircleView)
    {
        _footerCircleView = [[CSFooterCircleFunctionView alloc] initWithSubViews:[self setupSubViewsForFooterCircleFunctionView]];
        _footerCircleView.weakTableView = self.tableView;
        
        _footerCircleView.actionCompletion = ^(NSString *viewName, UIView<CSFooterCircleSubviewProtocol> *subview) {
            
        };
    }
    return _footerCircleView;
}
@end
