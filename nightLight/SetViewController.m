//
//  SetViewController.m
//  nightLight
//
//  Created by leo on 17/1/20.
//  Copyright © 2017年 Tang Yuan L inc. All rights reserved.
//

#import "SetViewController.h"
#import "ColorCell.h"


@interface SetViewController ()

@property (nonatomic,strong)NSArray *timeArray;
@property (nonatomic,strong)NSArray *colorArray;
@property (nonatomic,strong)IBOutlet UITableView *_tableView;
@end

@implementation SetViewController
@synthesize timeArray;
@synthesize colorArray;
@synthesize _tableView;


- (void)viewDidLoad {
    self.title = @"小夜灯设置";
    
    
    self.timeArray = @[[NSNumber numberWithInt:60*1],[NSNumber numberWithInt:60*3],[NSNumber numberWithInt:60*5],[NSNumber numberWithInt:60*10],[NSNumber numberWithInt:60*15],[NSNumber numberWithInt:60*20]];
    self.colorArray = @[[UIColor whiteColor],[UIColor yellowColor],[UIColor greenColor],[UIColor brownColor],[UIColor magentaColor]];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton setFrame:CGRectMake(0, 0, 45, 45)];
    [editButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [editButton setTitle:@"保存" forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    [self.navigationItem setRightBarButtonItem:right];
    
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setFrame:CGRectMake(0, 0, 45, 45)];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    [self.navigationItem setLeftBarButtonItem:left];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelButtonClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveButtonClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^(void){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LightConfigChanged" object:nil];
    }];
}

#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, KScreenWidth, 30)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:@"倒计时时间"];
        [label setTextColor:[UIColor lightGrayColor]];
        [label setFont:[UIFont systemFontOfSize:15]];
        [v addSubview:label];
        return v;
    }else if(section == 1){
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, KScreenWidth, 30)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor lightGrayColor]];
        [label setFont:[UIFont systemFontOfSize:15]];
        [label setText:@"屏幕颜色"];
        [v addSubview:label];
        return v;
    }
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return [timeArray count];
    }else if(section == 1){
        return [colorArray count];
    }
    return 0;
}


#pragma mark- UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier0 = @"identifier0";
    static NSString *identifier1 = @"identifier1";
    if(indexPath.section == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        NSNumber *time = [timeArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%d分钟",[time intValue]/60];
        
        
        NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:kTimeValue];
        if(time.intValue == number.intValue){
            //设置为选中状态
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return cell;
    }else if(indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if(cell == nil){
            cell = [[ColorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        UIColor *color = [colorArray objectAtIndex:indexPath.row];
        
        NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:kScreenColor];
        UIColor *defaultcolor = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
        
        [[(ColorCell *)cell colorView] setBackgroundColor:color];
        
        if([color isEqual:defaultcolor]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0){
        NSNumber *time = [timeArray objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:time forKey:kTimeValue];
    }else if(indexPath.section == 1){
        UIColor *color = [colorArray objectAtIndex:indexPath.row];
        NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:color];
        [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:kScreenColor];
    }
    
    [_tableView reloadData];
}
@end
