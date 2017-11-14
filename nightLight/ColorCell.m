//
//  ColorCell.m
//  nightLight
//
//  Created by leo on 17/1/20.
//  Copyright © 2017年 Tang Yuan L inc. All rights reserved.
//

#import "ColorCell.h"

@implementation ColorCell
@synthesize colorView;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        colorView = [[UIView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
        [colorView setBackgroundColor:[UIColor clearColor]];
        [[self contentView] addSubview:colorView];
        [colorView.layer setBorderWidth:0.5];
        [colorView.layer setBorderColor:[UIColor grayColor].CGColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
