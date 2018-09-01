//
//  UDPSender.h
//  TestObjcMsgSend
//
//  Created by shenyi on 2018/8/31.
//  Copyright © 2018年 shenyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UDPSender : NSObject

+ (instancetype)shareInstance;
- (void)sendUPDMessage:(NSString *)message;

@end
