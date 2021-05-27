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
    NSLog(@"== getter: %@", key);
    return objc_getAssociatedObject(object, (__bridge const void * _Nonnull)(key));
}
void setter(id object,SEL _cmd1,id newValue){
    NSString *key2 = NSStringFromSelector(_cmd1);
    key2 = [key2 substringWithRange:NSMakeRange(3, key2.length-4)];

    NSString *property = [key2 stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key2 substringToIndex:1] lowercaseString]];
    NSLog(@"== 0 setter: %@", property);
    
    
//    objc_setAssociatedObject(object, (__bridge const void * _Nonnull)(property), newValue, OBJC_ASSOCIATION_RETAIN);
    
    NSString *key = NSStringFromSelector(_cmd1);
    key = [[key substringWithRange:NSMakeRange(3, key.length-4)] lowercaseString];
    NSLog(@"== setter: %@", key);
    objc_setAssociatedObject(object, (__bridge const void * _Nonnull)(property), newValue, OBJC_ASSOCIATION_RETAIN);
}

+ (void)instance:(NSObject *)instance addPropertyString:(NSString *)property {
    if (![property isKindOfClass:NSString.class] || property.length == 0) {
        return;
    }
    
    // 首字符大写
    NSString *setProperty = [property stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[property substringToIndex:1] capitalizedString]];
    NSString *setString = [NSString stringWithFormat:@"set%@:", setProperty];
    NSLog(@"property:%@ setProperty:%@, setString:%@", property, setProperty, setString);
    if ([instance respondsToSelector:NSSelectorFromString(setString)]) {
        NSLog(@"已经添加成功\n");
        return;
    }
    
    // https://www.cnblogs.com/zhouxihi/p/6363103.html
    //type
    objc_property_attribute_t type = {"T", [[NSString stringWithFormat:@"@\"%@\"",NSStringFromClass([UILabel class])] UTF8String]};

    // C = copy   & = strong/retain
    objc_property_attribute_t ownership0 = { "&", "" };
    //N = nonatomic
    objc_property_attribute_t ownership = { "N", "" };
    //variable name
    objc_property_attribute_t backingivar  = { "V", [[NSString stringWithFormat:@"_%@", property] UTF8String] };
    //这个数组一定要按照此顺序才行
    objc_property_attribute_t attrs[] = { type, ownership0, ownership, backingivar};
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



//在目标target上添加关联对象，属性名propertyname(也能用来添加block)，值value
+ (void)addAssociatedWithtarget:(id)target withPropertyName:(NSString *)propertyName withValue:(id)value {
    id property = objc_getAssociatedObject(target, &propertyName);
    
    if(property == nil)
    {
        property = value;
        objc_setAssociatedObject(target, &propertyName, property, OBJC_ASSOCIATION_RETAIN);
    }
}
 
//获取目标target的指定关联对象值
+ (id)getAssociatedValueWithTarget:(id)target withPropertyName:(NSString *)propertyName {
    id property = objc_getAssociatedObject(target, &propertyName);
    return property;
}

@end
