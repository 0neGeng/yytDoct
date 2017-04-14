//
//  PatientRecord.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/7.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "PatientRecord.h"
#import "UserInfo.h"
#import "GTMBase64.h"
#import "CommonHeadView.h"
#import "DoctorAdviceHeadView.h"
#import "MBProgressHUD+MJ.h"
#import "DIYRefreshHeader.h"
@interface PatientRecord ()
@property(strong ,nonatomic) AFHTTPSessionManager *manager;

@property(strong ,nonatomic) NSDictionary *dict;
@end

@implementation PatientRecord

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = shareCustomManager();
    }
    return _manager;
}

- (NSDictionary *)dict {
    if (!_dict) {
        _dict = [NSDictionary dictionary];
    }
    return _dict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.mj_header = [DIYRefreshHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];

}

/*
 "admission_no" = 0069532;
 "bed_no" = 042;
 "in_date" = "2016-09-30";
 "medical_status" = 0;
 "out_date" = "";
 "pat_birth" = 70;
 "pat_card_no" = "";
 "pat_card_type" = 5;
 "pat_name" = "\U66fe\U65b0\U6dfb";
 "pat_sex" = 0;
 住院状态 0住院 1出院
 */
- (void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
}

- (void)loadData {
    [MBProgressHUD showMessage:@"正在加载中"];
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    [userInfo loadUserInfoFromSanbox];
    NSString *str;
    if ([self.titleStr isEqualToString:@"首次病程记录"]) {
        str = [NSString stringWithFormat:@"{\"record_id\":\"%@\",\"course_type\":\"1\",\"hospital_code\":\"%@\"}",_record_id,userInfo.hospital_code];
    }else if ([self.titleStr isEqualToString:@"日常病程记录"]){
        str = [NSString stringWithFormat:@"{\"record_id\":\"%@\",\"course_type\":\"2\",\"hospital_code\":\"%@\"}",_record_id,userInfo.hospital_code];
    }else{
        str = [NSString stringWithFormat:@"{\"record_id\":\"%@\",\"hospital_code\":\"%@\"}",_record_id,userInfo.hospital_code];
    }

    NSLog(@"%@-",str);
    NSData *data = [str dataUsingEncoding:NSASCIIStringEncoding];
    NSString *str3 = [GTMBase64 stringByEncodingData:data];
    NSString *url;
    if ([self.titleStr isEqualToString:@"入院记录"]) {
        url = [NSString stringWithFormat:@"%@/openapi/gateway?app_id=csyy123&v=1000&format=json&sign_type=3&timestamp=1477277052&sessionid=&method=yyt.base.wards.in.hospital.record.get&sign=29d9e9e130a90e993cb2c1e11c23a032&data=%@",BaseUrl,str3];
    }else if ([self.titleStr isEqualToString:@"首次病程记录"]) {
        url = [NSString stringWithFormat:@"%@/openapi/gateway?app_id=csyy123&v=1000&format=json&sign_type=3&timestamp=1477277052&sessionid=&method=yyt.base.wards.course.list.get&sign=29d9e9e130a90e993cb2c1e11c23a032&data=%@",BaseUrl,str3];
    }else if ([self.titleStr isEqualToString:@"日常病程记录"]) {
        url = [NSString stringWithFormat:@"%@/openapi/gateway?app_id=csyy123&v=1000&format=json&sign_type=3&timestamp=1477277052&sessionid=&method=yyt.base.wards.course.list.get&sign=29d9e9e130a90e993cb2c1e11c23a032&data=%@",BaseUrl,str3];
    }else if ([self.titleStr isEqualToString:@"手术记录"]) {
        url = [NSString stringWithFormat:@"%@/openapi/gateway?app_id=csyy123&v=1000&format=json&sign_type=3&timestamp=1477277052&sessionid=&method=yyt.base.wards.surgery.record.get&sign=29d9e9e130a90e993cb2c1e11c23a032&data=%@",BaseUrl,str3];
    }else{
        url = [NSString stringWithFormat:@"%@/openapi/gateway?app_id=csyy123&v=1000&format=json&sign_type=3&timestamp=1477277052&sessionid=&method=yyt.base.wards.out.hospital.record.get&sign=29d9e9e130a90e993cb2c1e11c23a032&data=%@",BaseUrl,str3];
    }
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [MBProgressHUD hideHUD];
        NSLog(@"%@",dict[@"result_message"]);
        [self.tableView.mj_header endRefreshing];
        if ([dict[@"result_message"] isEqualToString:@"成功"]) {
            self.dict = dict[@"result"];
            [self.tableView reloadData];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:self.dict[@"result_message"]];
        [self.tableView.mj_header endRefreshing];
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if ([self.titleStr isEqualToString:@"首次病程记录"] || [self.titleStr isEqualToString:@"日常病程记录"] || [self.titleStr containsString:@"院记录"]) {
        return 2;
    }else if ([self.titleStr isEqualToString:@"手术记录"]) {
        return 5;
    }else{
       return 8;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 172;
    }else if (indexPath.section == 1){
        CGSize size;
        if ([self.titleStr containsString:@"病程记录"]) {
            size = [self.dict[@"course_items"][0][@"course_detail"] boundingRectWithSize:CGSizeMake(self.tableView.wg_width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
        }else if ([self.titleStr containsString:@"出院记录"]) {
            size = [self.dict[@"out_advice"] boundingRectWithSize:CGSizeMake(self.tableView.wg_width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
        }else{
            size = [self.dict[@"zs"] boundingRectWithSize:CGSizeMake(self.tableView.wg_width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
        }
        if (size.height == 0) {
            return 64;
        }else {
        return size.height;
        }
    }else {
        return 64;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    DoctorAdviceHeadView *headView = [DoctorAdviceHeadView shareHeadView];
    if (section == 0) {
        headView.leftLabel.text = @"患者信息";
    }else{
        if ([self.titleStr isEqualToString:@"手术记录"]) {
            switch (section) {
                case 1:
                    headView.leftLabel.text = @"术前记录";
                    break;
                case 2:
                    headView.leftLabel.text = @"术中内容";
                    break;
                case 3:
                    headView.leftLabel.text = @"术中诊断";
                    break;
                case 4:
                    headView.leftLabel.text = @"手术过程";
                    break;
                default:
                    break;
            }
        }else {
            switch (section) {
                case 1:
                    
                    if ([self.titleStr containsString:@"病程记录"]) {
                        headView.leftLabel.text = self.titleStr;
                        NSLog(@"%@",self.dict);
                        headView.rightLabel.text = self.dict[@"course_items"][0][@"course_time"];
                    }else{
                        
                        headView.leftLabel.text = @"主诉";
                    }
                    
                    break;
                case 2:
                    headView.leftLabel.text = @"现病史";
                    break;
                case 3:
                    headView.leftLabel.text = @"个人史";
                    break;
                case 4:
                    headView.leftLabel.text = @"婚育史";
                    break;
                case 5:
                    headView.leftLabel.text = @"体格检查";
                    break;
                case 6:
                    headView.leftLabel.text = @"专科检查";
                    break;
                case 7:
                    headView.leftLabel.text = @"辅助检查";
                    break;
                    
                    
                default:
                    break;
            }
        }

    }
    return headView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.numberOfLines = 0;
    cell.clipsToBounds = YES;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[CommonHeadView class]]) {
            [view removeFromSuperview];
        }
    }
    if (indexPath.section == 0) {
        CommonHeadView *commonHeadView = [CommonHeadView shareHeadView];
        [cell.contentView addSubview:commonHeadView];
        commonHeadView.dataDict = self.dict;
//        commonHeadView.department.text = self.dict[@"dept_name"];
        NSLog(@"%@===%@",self.dataDict,self.dict);
        commonHeadView.isHidden = YES;
    }else{
        switch (indexPath.section) {
            case 1:
                if ([self.titleStr containsString:@"病程记录"]) {

                     cell.textLabel.text = self.dict[@"course_items"][0][@"course_detail"];
                }else if ([self.titleStr containsString:@"出院记录"]) {
                    cell.textLabel.text = self.dict[@"out_advice"];
                }else{
                    cell.textLabel.text = self.dict[@"zs"];
                }
    
                break;
             case 2:
                cell.textLabel.text = self.dict[@"xbs"];

                break;
                case 3:

                    cell.textLabel.text = self.dict[@"grs"];

                break;
                case 4:

                    cell.textLabel.text = self.dict[@"hys"];

                break;
                case 5:
 
                    cell.textLabel.text = self.dict[@"check_tg"];

                break;
                case 6:

                    cell.textLabel.text = self.dict[@"check_zk"];

                break;
                case 7:
 
                    cell.textLabel.text = self.dict[@"check_fz"];

                break;
            default:
                break;
        }
        if (cell.textLabel.text.length <= 0) {
            cell.textLabel.text = @"暂无数据";
        }
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
