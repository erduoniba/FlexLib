//
//  CustomViewController2.m
//  FlexSwiftDemo
//
//  Created by 邓立兵 on 2021/5/26.
//  Copyright © 2021 wbg. All rights reserved.
//

#import "CustomViewController2.h"

#import "FlexSwiftDemo-Swift.h"

#import <objc/runtime.h>
#import <FlexLib/HDAddProperty.h>

@interface CustomViewController2 ()

@property (nonatomic, strong) FlexRootView *rootView;

@end

@implementation CustomViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rootView = [FlexRootView loadWithNodeFile:@"CustomViewController" Owner:self];
    [self.view addSubview:_rootView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @try {
            UILabel *label = [self valueForKey:@"sText"];
            [label setViewAttr:@"text" Value:@"xxxx"];
            [label setViewAttr:@"color" Value:@"#ffffff"];
        } @catch (NSException *exception) {
            NSLog(@"exception : %@", exception);
        } @finally {
            
        }
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
