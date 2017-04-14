//
//  AdviceListVC.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "AdviceListVC.h"
#import "UserInfo.h"
#import "GTMBase64.h"
#import "DoctorAdviceHeadView.h"
#import "AdviceDetail.h"
#import "PatientRecord.h"
@interface AdviceListVC ()


@property(strong ,nonatomic) NSArray *adviceListArray;
@end

@implementation AdviceListVC



- (NSArray *)adviceListArray {
    if (!_adviceListArray) {
        if ([_titleStr isEqualToString:@"患者医嘱"]) {
            _adviceListArray = @[@"长期医嘱",@"临时医嘱",@"中草药医嘱",@"检验医嘱",@"技诊医嘱",@"手术医嘱",@"西药出院医嘱",@"中成药住院医嘱",@"中草药出院医嘱"];
        }else{
            _adviceListArray = @[@"入院记录",@"首次病程记录",@"日常病程记录",@"手术记录",@"出院记录"];
        }
        
    }
    return _adviceListArray;
}

- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.adviceListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DoctorAdviceHeadView *headView = [DoctorAdviceHeadView shareHeadView];
    headView.leftLabel.text = _leftStr;
    return headView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor colorWithRed:51 green:51 blue:51 alpha:1];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.adviceListArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
       UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self.titleStr containsString:@"医嘱"]) {
        AdviceDetail *adviceDetail = [[AdviceDetail alloc] init];
        adviceDetail.titleStr = cell.textLabel.text;
        adviceDetail.dataDict = _dataDict;
        adviceDetail.index = indexPath.row + 1;
        adviceDetail.departmentStr = self.departmentStr;
        [self.navigationController pushViewController:adviceDetail animated:YES];
    }else{
        PatientRecord *patientRecord = [[PatientRecord alloc] init];
        patientRecord.titleStr = cell.textLabel.text;
        patientRecord.dataDict = _dataDict;
        patientRecord.record_id = _record_id;
        [self.navigationController pushViewController:patientRecord animated:YES];
    }

}
@end
