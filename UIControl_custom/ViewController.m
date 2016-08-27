//
//  ViewController.m
//  Ttt
//
//  Created by wanggy820 on 16/8/27.
//  Copyright © 2016年 wanggy820. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+Custom.h"

@interface ViewController ()
- (IBAction)btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;

- (IBAction)switchValue:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.btn.custom_acceptEventInterval = 1;
    self.mySwitch.custom_acceptEventInterval = 3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn:(id)sender {
    NSLog(@"%s",__func__);
}

- (IBAction)switchValue:(id)sender {
    NSLog(@"%s",__func__);
}
@end
