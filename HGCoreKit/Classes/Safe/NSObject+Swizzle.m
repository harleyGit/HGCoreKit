//
//  NSObject+Swizzle.m
//  MLC
//
//  Created by Harley Huang on 9/5/2023.
//  Copyright © 2023 HuangGang'sMac. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import "PublicMethods.h"

@implementation NSObject (Swizzle)


+ (void)swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    swizzleClassMethod(self.class, origSelector, newSelector);
}

- (void)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    swizzleInstanceMethod(self.class, origSelector, newSelector);
}


@end
