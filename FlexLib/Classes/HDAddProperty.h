//
//  HDAddProperty.h
//  HDMasterProject
//
//  Created by 邓立兵 on 2021/5/26.
//  Copyright © 2021 HarryDeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDAddProperty : NSObject

+ (void)instance:(NSObject *)instance addPropertyString:(NSString *)property className:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
