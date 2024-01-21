//
//  HGDeviceInfoUtil.m
//  HGCoreSDK
//
//  Created by GangHuang on 2023/7/19.
//  系统信息数据:https://www.twblogs.net/a/5d15f29dbd9eee1e5c82866f

#import "HGDeviceInfoUtil.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <net/if.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"//苹果代码
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
#define IP_ADDR_IPv6_2  @"ipv6_2"

@implementation HGDeviceInfoUtil


///有问题丢弃
+ (NetDataType)getCurrentNetDataType {//打开飞行模式,Wi-Fi没有打开 还能获取到Wi-Fi的ip地址
    NetDataType netType = NetDataTypeNone;
    
    NSString *mobilCellStr = [self na_ipAddressCell];
    if(mobilCellStr.length > 0){
        netType = NetDataTypeMobileData;
    }
    
    
    NSString *ipAddr = [self na_ipAddressWIFI];
    if(ipAddr.length > 0){
        netType |= NetDataTypeWIFI;
    }
    
    if(ipAddr.length <= 0 && mobilCellStr.length <= 0){
        netType |= NetDataTypeFlightMode;
    }
    
    return netType;
}


+ (NetDataType)getCurrentNetDataType_V2 {//飞行模式下获取不到Wi-Fi的IP地址,除非Wi-Fi打开了
    NetDataType netType = NetDataTypeNone;
    
    NSDictionary *dict = [self getMobileIpList];
    if(dict.allKeys.count > 0){
        netType = NetDataTypeMobileData;
    }
    
    
    NSString *ipAddr = [self localWiFiIPAddress_V2];
    if(ipAddr.length > 0){
        netType |= NetDataTypeWIFI;
    }
    
    if(ipAddr.length <= 0 && dict.allKeys.count <= 0){
        netType |= NetDataTypeFlightMode;
    }
    

    return netType;
}


+ (NSString *)getMobileNetType {
    NSString *currentNet = @"蜂窝网络";
    
    NSDictionary *dict = [self getMobileIpList];
    if(dict.allKeys.count <= 0){
        currentNet = @"飞行模式-没有开启蜂窝网络";
        return currentNet;
    }
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSString *currentStatus = info.currentRadioAccessTechnology;
    
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyGPRS]) {
        currentNet = @"GPRS";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyEdge]) {
        currentNet = @"2.75G EDGE";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyWCDMA]){
        currentNet = @"3G";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyHSDPA]){
        currentNet = @"3.5G HSDPA";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyHSUPA]){
        currentNet = @"3.5G HSUPA";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMA1x]){
        currentNet = @"2G";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]){
        currentNet = @"3G";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]){
        currentNet = @"3G";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]){
        currentNet = @"3G";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyeHRPD]){
        currentNet = @"HRPD";
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyLTE]){
        currentNet = @"4G";
    }
//    else if (@available(iOS 14.0, *)) {//Xcode版本低了或者其他配置造成的导致运行报错
//        if ([currentStatus isEqualToString:CTRadioAccessTechnologyNRNSA]){
//            currentNet = @"5G NSA";
//        }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyNR]){
//            currentNet = @"5G";
//        }
//    }
    return currentNet;
}



///通过苹果的方法获取Wi-Fi类型是否开着
+(NSString *)localWiFiIPAddress_V2 {
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    NSString *net = @"";
    switch (internetStatus) {
        case ReachableViaWiFi:
            net = @"WIFI";
            break;
            
        case ReachableViaWWAN://蜂窝数据
            net = @"";
            //net = [self getNetType ];   //判断具体类型
            break;
            
        case NotReachable://当前无网路连接
            net = @"";
            
        default:
            break;
    }
 
    
    return net;
}


///有问题:经测试在部分机型可能不是en0但是开启了Wi-Fi
+(NSString *)localWiFiIPAddress {
  BOOL success;
  struct ifaddrs * addrs;
  const struct ifaddrs * cursor;
  success = getifaddrs(&addrs) == 0;
  if (success) {
    cursor = addrs;
    while (cursor != NULL) {
      // the second test keeps from picking up the loopback address
      if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
      {
        NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
        if ([name isEqualToString:@"en0"])  // Wi-Fi adapter,这个也不行在部分机型可能不是en0但是开启了Wi-Fi
          return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
      }
      cursor = cursor->ifa_next;
    }
    freeifaddrs(addrs);
  }
  return @"";
}

+(NSString *)getIpAddressV4 {
    NSString * ipAddr = @"";
       
    NSDictionary *dict = [self getMobileIpList];

    if ([[dict allKeys]containsObject:@"pdp_ip0/ipv4"]) {
        ipAddr = [dict objectForKey:@"pdp_ip0/ipv4"];
    }
       
    if(ipAddr.length <= 0){
        ipAddr = [self localWiFiIPAddress];
    }
       
    return ipAddr;
}

//获取 pdp_ip0/ipv4  pdp_ip0/ipv6
//获取 pdp_ip0/ipv4  pdp_ip0/ipv6 pdp_ip0/ipv6_2
+ (NSDictionary *)getMobileIpList {
    BOOL foundIpv6 = NO;
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            if (![[NSString stringWithUTF8String:interface->ifa_name] containsString:@"pdp_ip0"]) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                NSString *ip;
                
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        ip = [NSString stringWithUTF8String:addrBuf];
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        ip = [NSString stringWithUTF8String:addrBuf];
                        
                        //链路地址不能要
                        if([ip hasPrefix:@"fe80:"]){
                            continue;
                        }
                        //本地地址不能要
                        if([ip isEqualToString:@"::1"]){
                            continue;
                        }
                        
                        if(!foundIpv6){
                            type = IP_ADDR_IPv6;
                            foundIpv6 = YES;
                        }else{
                            type = IP_ADDR_IPv6_2;//找到第二个ipv6地址
                        }
                    }
                }
                
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    
                    //处理一下ipv6中含有%的情况，android有这种可能， ios暂时还没有发现，但是代码先放在这里。
                    if([ip containsString:@"%"]){
                        NSRange range = [ip rangeOfString:@"%"];
                        ip = [ip substringToIndex:range.location];
                    }
                    
                    addresses[key] = ip;
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
  
    return addresses;
}


+ (NSString *)na_ipAddressWithIfaName:(NSString *)name {
    if (name.length == 0) return nil;
    NSString *address = nil;
    struct ifaddrs *addrs = NULL;
    if (getifaddrs(&addrs) == 0) {
        struct ifaddrs *addr = addrs;
        while (addr) {
            if ([[NSString stringWithUTF8String:addr->ifa_name] hasPrefix:name]) {
                sa_family_t family = addr->ifa_addr->sa_family;
                if (family == AF_INET) {
                    switch (family) {
                        case AF_INET: { // IPv4
                            char str[INET_ADDRSTRLEN] = {0};
                            inet_ntop(family, &(((struct sockaddr_in *)addr->ifa_addr)->sin_addr), str, sizeof(str));
                            if (strlen(str) > 0) {
                                address = [NSString stringWithUTF8String:str];
                            }
                        } break;
                            
                        case AF_INET6: { // IPv6
                            char str[INET6_ADDRSTRLEN] = {0};
                            inet_ntop(family, &(((struct sockaddr_in6 *)addr->ifa_addr)->sin6_addr), str, sizeof(str));
                            if (strlen(str) > 0) {
                                address = [NSString stringWithUTF8String:str];
                            }
                        }break;
                            
                        default: break;
                    }
                }
                
                if (address) break;
            }
            addr = addr->ifa_next;
        }
    }
    freeifaddrs(addrs);
    return address;
}

+ (NSString *)na_ipAddressWIFI {
    return [self na_ipAddressWithIfaName:@"en"];
}

+ (NSString *)na_ipAddressCell {
    return [self na_ipAddressWithIfaName:@"pdp_ip0"];
}

@end
