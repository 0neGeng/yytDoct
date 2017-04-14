//
//  DoctorListTableVC.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/16.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "DoctorListTableVC.h"
#import "WGMenu.h"
#import "UserInfo.h"
#import "GTMBase64.h"
#import "DoctorListCell.h"
#import "CloudHomeVC.h"
#import "MBProgressHUD+MJ.h"
#import "LoadFailView.h"
@interface DoctorListTableVC ()

@property(nonatomic , strong) WGMenuItem *item;
@property (nonatomic, strong) NSMutableArray *items;
@property(strong ,nonatomic) NSMutableArray *departmentArray;
@property(strong ,nonatomic) NSMutableArray *IDArray;
@property(strong ,nonatomic) NSMutableArray *permissionArray;
@property(nonatomic, weak) UIButton *titleBtn;
@property(strong ,nonatomic) AFHTTPSessionManager *manager;
@property(nonatomic, assign) NSInteger selectIndex;
@property(strong ,nonatomic) NSArray *resultArray;
@property (weak, nonatomic) LoadFailView *failView;
@end

@implementation DoctorListTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTitleBtn];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    LoadFailView *view = [LoadFailView loadFailView];
    view.frame = CGRectMake(0, 0, YYTScreenW, YYTScreenH);
    [self.tableView addSubview: view];
    view.hidden = true;
    view.reLoadData = ^{
        [self loadData];
    };
    _failView = view;
}

- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;//department_id   permission
    //科室
    NSString *allDep = dataDict[@"department_name"];
    NSArray *depArray = [allDep componentsSeparatedByString:@","];
    [WGMenu setHasShadow:YES];
    for (NSInteger i = 0; i < depArray.count; i++) {
        NSString *title = depArray[i];
        if (title.length > 0) {
            [self.departmentArray addObject:title];
            [self.items addObject:[WGMenuItem menuItem:title image:nil tag:i userInfo:@{@"title":@"Menu"}]];
        }
    }
   
    //科室id
    NSString *allID = dataDict[@"department_id"];
    NSArray *IDTemArray = [allID componentsSeparatedByString:@","];
    for (int i = 0; i < IDTemArray.count; i ++) {
          NSString *ID = IDTemArray[i];
        if (ID.length >0) {
            [self.IDArray addObject:ID];
        }
    }
    
    //permission
    NSString *allPermission = dataDict[@"permission"];
    NSArray *PermissionTemArray = [allPermission componentsSeparatedByString:@","];
    for (int i = 0; i < PermissionTemArray.count; i ++) {
        NSString *permission = PermissionTemArray[i];
        if (permission.length >0) {
            [self.permissionArray addObject:permission];
        }
    }
    
    [self loadData];
}

- (void)loadData {

    
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    [userInfo loadUserInfoFromSanbox];
    [MBProgressHUD showMessage:@"正在加载中"];
    NSLog(@"%@==%@==%zd",self.IDArray[self.selectIndex],self.dataDict[@"doctor_code"],self.selectIndex);
    
    if (userInfo.menuItem) {
        self.selectIndex = userInfo.menuItem;
    }
    
    NSString *str1;
    if ([self.permissionArray containsObject:self.IDArray[self.selectIndex]]) {
        str1 = [NSString stringWithFormat:@"{\"hospital_code\":\"lczyy\",\"dept_code\":\"%@\",\"doctor_code\":\"\"}",self.IDArray[self.selectIndex]];
    } else {
        str1 =  [NSString stringWithFormat:@"{\"hospital_code\":\"lczyy\",\"dept_code\":\"%@\",\"doctor_code\":\"%@\"}",self.IDArray[self.selectIndex],self.dataDict[@"doctor_code"]];
    }
  
    NSData *data1 = [str1 dataUsingEncoding:NSASCIIStringEncoding];
    NSString *str3 = [GTMBase64 stringByEncodingData:data1];
    
    NSString *url = [NSString stringWithFormat:@"%@/openapi/gateway?app_id=csyy123&v=1000&format=json&sign_type=3&timestamp=1477277052&sessionid=&method=yyt.base.wards.doctor.get&sign=29d9e9e130a90e993cb2c1e11c23a032&data=%@",BaseUrl,str3];

    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [MBProgressHUD hideHUD];
        self.failView.hidden = true;
        if ([dict[@"result_message"] isEqualToString:@"成功"]) {
       
            self.resultArray = dict[@"result"];
              [self.tableView reloadData];
        }else {
            [MBProgressHUD showError:dict[@"result_message"]];
        }
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"服务繁忙"];
        self.failView.hidden = false;
        [self.failView setImgView:@"img_dataloading_failure" :@"OMG,服务器消化不良" :@"请稍后重试"];
        NSLog(@"%@",error);
    }];

}

- (NSArray *)resultArray {
    if (!_resultArray) {
        _resultArray = [NSArray array];
    }
    
    return _resultArray;
}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = shareCustomManager();
    }
    return _manager;
}

- (NSMutableArray *)departmentArray {
    if (!_departmentArray) {
        _departmentArray = [NSMutableArray array];
    }
    return _departmentArray;
}

- (NSMutableArray *)IDArray {
    if (!_IDArray) {
        _IDArray = [NSMutableArray array];
    }
    return _IDArray;
}

- (NSMutableArray *)permissionArray {
    if (!_permissionArray) {
        _permissionArray = [NSMutableArray array];
    }
    return _permissionArray;
}

- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)setupTitleBtn {
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *titStr = self.departmentArray[0];
    NSLog(@"%@",titStr);
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    [userInfo loadUserInfoFromSanbox];
    if (userInfo.menuItem) {
        [titleBtn setTitle:self.departmentArray[userInfo.menuItem] forState:UIControlStateNormal];
    }else {
        
        [titleBtn setTitle:titStr forState:UIControlStateNormal];
    }
    [titleBtn setImage:[UIImage imageNamed:@"icon_pulldown_arrow"] forState:UIControlStateNormal];
    [titleBtn sizeToFit];
    _titleBtn = titleBtn;
    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"%@==%@",NSStringFromCGRect(titleBtn.imageView.frame),NSStringFromCGRect(titleBtn.titleLabel.frame));
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, titleBtn.titleLabel.wg_width, 0, -titleBtn.titleLabel.wg_width);
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -titleBtn.imageView.wg_width, 0, titleBtn.imageView.wg_width);
    self.navigationItem.titleView = titleBtn;
}

- (void)titleBtnClick:(UIButton *)btn {
    [WGMenu setTintColor:[UIColor whiteColor]];
    [WGMenu setSelectedColor:[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1]];
    if ([WGMenu isShow]){
        [WGMenu dismissMenu];
    } else {
        CGFloat y = 0;
        if ([UIScreen mainScreen].bounds.size.height == self.view.wg_height) {
            y = 64;
        }else{
            y = 0;
        }
        [WGMenu showMenuInView:self.view fromRect:CGRectMake(self.view.wg_width /2 - 10, y, 20, 0) menuItems:self.items selected:^(NSInteger index, WGMenuItem *item) {
            self.item = item;
            [self setupMenuBtnClick];
        }];
    }

}

- (void)setupMenuBtnClick {

    NSLog(@"%zd==%@",self.item.tag,self.item);
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    userInfo.menuItem = self.item.tag;
    [userInfo saveUserInfoToSanbox];
    
    NSInteger tag = self.item.tag;
    self.selectIndex = tag;
    [self.titleBtn setTitle:self.departmentArray[tag] forState:UIControlStateNormal];
    [self loadData];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.resultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DoctorListCell *cell = [DoctorListCell doctorListCellWithTableView:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.dataDict = self.resultArray[indexPath.row];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54+ 12;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CloudHomeVC *cloudHome = [[CloudHomeVC alloc] init];
    cloudHome.dataDict = self.resultArray[indexPath.row];
    [self.navigationController pushViewController:cloudHome animated:YES];
  
}
@end
