//
//  LameTool.h
//  JBaoProduct1
//
//  Created by zero_rb on 2020/9/25.
//  Copyright © 2020 jibao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LameTool : NSObject
+ (void)conventToMp3WithCafFilePath:(NSString *)cafFilePath
                        mp3FilePath:(NSString *)mp3FilePath
                         sampleRate:(int)sampleRate
                           callback:(void(^)(BOOL result))callback;
@end

NS_ASSUME_NONNULL_END
