//
//  CLBAppConfiguration.h
//  ClickLab
//
//  Copyright © 2017 ClickLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLBAppConfiguration : NSObject

/**
 Your ClickLab ApiKey.
 */
@property (nonatomic, copy, readonly) NSString * _Nonnull apiKey;

/**
 The country of the current user.
 */
@property (nonatomic) NSString * _Nonnull country;

/**
 The email of the current user.
 */
@property (nonatomic) NSString * _Nonnull email;

/**
 Creates a configuration with default settings and the given client key.

 @param key Your project's key from ClickLab.
 @return Configuration with default settings and the given client key.
 */
+ (_Nonnull instancetype)configurationWithKey:(NSString * _Nonnull)key;

@end
