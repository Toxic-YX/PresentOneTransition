//
//  YXShareSingle.h
//  Created by Rookie_YX on 16/10/20.
//  单例

#ifndef YXShareSingle_h
#define YXShareSingle_h


#define YXSingletonH(name) + (instancetype)share##name;

#define YXSingletonM(name)\
static id _instance;\
+ (instancetype)share##name\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\



#endif /* YXShareSingle_h */

