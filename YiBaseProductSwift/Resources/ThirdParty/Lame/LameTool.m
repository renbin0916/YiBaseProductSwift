//
//  LameTool.m
//  JBaoProduct1
//
//  Created by zero_rb on 2020/9/25.
//  Copyright © 2020 jibao. All rights reserved.
//

#import "LameTool.h"
//#import "lame.h"


/// this file's func work with lame, if it needed we should add lame to project
@implementation LameTool


+ (void)conventToMp3WithCafFilePath:(NSString *)cafFilePath
                        mp3FilePath:(NSString *)mp3FilePath
                         sampleRate:(int)sampleRate
                           callback:(void(^)(BOOL result))callback
{
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
//        @try {
//            int read, write;
            
//            FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
//            fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
//            FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb+");  //output 输出生成的Mp3文件位置
//
//            const int PCM_SIZE = 8192;
//            const int MP3_SIZE = 8192;
//            short int pcm_buffer[PCM_SIZE*2];
//            unsigned char mp3_buffer[MP3_SIZE];
//
//            lame_t lame = lame_init();
//            lame_set_num_channels(lame,1);//设置1为单通道，默认为2双通道
//            lame_set_in_samplerate(lame, sampleRate);
//            lame_set_VBR(lame, vbr_default);
//            lame_init_params(lame);
//
//            do {
//
//                read = (int)fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
//                if (read == 0) {
//                    write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
//
//                } else {
//                    write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
//                }
//
//                fwrite(mp3_buffer, write, 1, mp3);
//
//            } while (read != 0);
//
//            lame_mp3_tags_fid(lame, mp3);
//
//            lame_close(lame);
//            fclose(mp3);
//            fclose(pcm);
//        }
//        @catch (NSException *exception) {
//            if (callback) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    callback(NO);
//                });
//            }
//        }
//        @finally {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                callback(YES);
//            });
//        }
//    });
}


@end
