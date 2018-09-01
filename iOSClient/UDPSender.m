//
//  UDPSender.m
//  TestObjcMsgSend
//
//  Created by shenyi on 2018/8/31.
//  Copyright © 2018年 shenyi. All rights reserved.
//

#import "UDPSender.h"
#import "GCDAsyncUdpSocket.h"

#define HOST @"192.168.2.4"
#define PORT 12345

@interface UDPSender ()<GCDAsyncUdpSocketDelegate>
{
    GCDAsyncUdpSocket *_udpSocket;
}

@end

@implementation UDPSender

#pragma mark - initialization
static UDPSender *_instance = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
        [_instance initUDP];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [UDPSender shareInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return [UDPSender shareInstance];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [UDPSender shareInstance];
}

#pragma mark - UDP
- (void)sendUPDMessage:(NSString *)message {
    [[UDPSender shareInstance] sendMessage:message];
}

- (void)initUDP {
    if (!_udpSocket) {
        _udpSocket = nil;
    }
    _udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
}

- (void)sendMessage:(NSString *)message {
    NSString *logString = [self appendTimeString:message];
    [_udpSocket sendData:[logString dataUsingEncoding:NSUTF8StringEncoding] toHost:HOST port:PORT withTimeout:-1 tag:1];
}

- (NSString *)appendTimeString:(NSString *)message {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate *date = [NSDate date];
    NSString *dateString = [formatter stringFromDate:date];
    NSString *logString = [NSString stringWithFormat:@"%@---%@", dateString, message];
    return logString;
}

#pragma mark - GCDAsyncUdpSocketDelegate
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    NSLog(@"发送信息成功");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    NSLog(@"发送信息失败");
}

@end
