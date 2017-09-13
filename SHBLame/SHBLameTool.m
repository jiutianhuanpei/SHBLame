//
//  SHBLameTool.m
//  ValueDemo
//
//  Created by 沈红榜 on 2017/9/13.
//  Copyright © 2017年 沈红榜. All rights reserved.
//

#import "SHBLameTool.h"
#import "lame.h"

void VoiceToMP3(NSURL *path, void(^handler)(NSURL *resultUrl)) {
    NSURL *mp3FilePath = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:@"record.mp3"]];
    @try {
        int read, write;
        FILE *pcm = fopen([path fileSystemRepresentation], "rb");
        fseek(pcm, 4*1024, SEEK_CUR);
        FILE *mp3 = fopen([mp3FilePath fileSystemRepresentation], "wb");
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        do {
            read = (int)fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        handler(nil);
    }
    @finally {
        handler(mp3FilePath);
    }
}
