//
//  HDAddProperty.m
//  HDMasterProject
//
//  Created by 邓立兵 on 2021/5/26.
//  Copyright © 2021 HarryDeng. All rights reserved.
//

#import "HDAddProperty.h"

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation HDAddProperty

id getter(id object,SEL _cmd1){
    NSString *key = NSStringFromSelector(_cmd1);
    return objc_getAssociatedObject(object, (__bridge const void * _Nonnull)(key));
}

void setter(id object,SEL _cmd1,id newValue){
    //移除set
    NSString *key = [NSStringFromSelector(_cmd1) stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@""];
    //首字母小写
    NSString *head = [key substringWithRange:NSMakeRange(0, 1)];
    head = [head lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:head];
    //移除后缀 ":"
    key = [key stringByReplacingCharactersInRange:NSMakeRange(key.length - 1, 1) withString:@""];
    NSString *kk = [key copy];
    objc_setAssociatedObject(object, (__bridge const void * _Nonnull)(kk), newValue, OBJC_ASSOCIATION_RETAIN);
}

+ (void)instance:(NSObject *)instance addPropertyString:(NSString *)property className:(NSString *)className {
    // 首字符大写
    NSString *setProperty = [property stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[property substringToIndex:1] capitalizedString]];
    NSString *setString = [NSString stringWithFormat:@"set%@:", setProperty];
    if ([instance respondsToSelector:NSSelectorFromString(setString)]) {
        NSLog(@"已经添加成功\n");
        return;
    }
    
    // https://www.cnblogs.com/zhouxihi/p/6363103.html
    //type
    objc_property_attribute_t type = {"T", [[NSString stringWithFormat:@"@\"%@\"", className] UTF8String]};
    // C = copy   & = strong/retain
    objc_property_attribute_t ownership0 = { "&", "" };
    //N = nonatomic
    objc_property_attribute_t ownership = { "N", "" };
    //variable name
    objc_property_attribute_t backingivar  = { "V", [[NSString stringWithFormat:@"_%@", property] UTF8String] };
    //这个数组一定要按照此顺序才行
    objc_property_attribute_t attrs[] = { type, ownership0, ownership,backingivar};
    BOOL add = class_addProperty(instance.class, [property UTF8String], attrs, 4);
    if (add) {
        NSLog(@"添加成功\n");
    }
    else{
        NSLog(@"添加失败\n");
    }
    
    class_addMethod(instance.class, NSSelectorFromString(property), (IMP)getter, "@@:");
    class_addMethod(instance.class, NSSelectorFromString(setString), (IMP)setter, "v@:@");
}

@end
