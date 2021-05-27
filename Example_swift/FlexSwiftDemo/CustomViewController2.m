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
//@property (nonatomic, strong) UILabel *fText;

@end

@implementation CustomViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rootView = [FlexRootView loadWithNodeFile:@"CustomViewController" Owner:self];
    [self.view addSubview:_rootView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UILabel *label = [HDAddProperty getAssociatedValueWithTarget:self withPropertyName:@"sText"];
        [label setViewAttr:@"text" Value:@"xxxx"];
        
        @try {
            
        } @catch (NSException *exception) {
            NSLog(@"exception : %@", exception);
        } @finally {
            
        }
        
//        [self getAllProperties];
    });
}

//获取对象的所有属性
- (NSArray *)getAllProperties {
    u_int count;

    objc_property_t *properties =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        const char* char_f = property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [propertiesArray addObject:propertyName];
        NSLog(@"propertyName: %@ value: %@", propertyName, [self valueForKey:propertyName]);
    }

    free(properties);
    NSLog(@"propertiesArray: %@", propertiesArray);
    return propertiesArray;
}

- (UILabel *)getValueProperty:(NSString *)property {
    u_int count;
    objc_property_t *properties =class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) {
        const char* char_f = property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        if ([property isEqualToString:propertyName]) {
            id propertyValue = [self valueForKey:propertyName];
            free(properties);
            return propertyValue;
        }
    }

    free(properties);
    return nil;

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
