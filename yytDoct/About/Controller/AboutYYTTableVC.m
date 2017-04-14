//
//  AboutYYTTableVC.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/22.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "AboutYYTTableVC.h"
#import "AboutYYTView.h"
@interface AboutYYTTableVC ()

@property(weak ,nonatomic) AboutYYTView *aboutView;

@end

@implementation AboutYYTTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于云医通";
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
    self.aboutView = [AboutYYTView aboutViewForXib];
    self.aboutView.frame = CGRectMake(0, 0, YYTScreenW, self.aboutView.ViewHeight);
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:self.aboutView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.aboutView.ViewHeight;
}

@end
