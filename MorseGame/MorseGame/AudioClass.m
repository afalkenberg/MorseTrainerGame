//
//
//  Created by Andreas Falkenberg on 1/27/15.
//  Copyright (c) 2015 Andreas Falkenberg. All rights reserved.
//
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.

//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.

//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

#import <Foundation/Foundation.h>
#import "AudioClass.h"


// implementation section //


@implementation AudioClass



-(void)launching:(int) n
{
    
    AudioComponentDescription outputUnitDescription =
    {
        .componentType         = kAudioUnitType_Output,
        .componentSubType      = kAudioUnitSubType_RemoteIO,
        .componentManufacturer = kAudioUnitManufacturer_Apple
    };
    
    
    AudioComponent outputComponent = AudioComponentFindNext(NULL, &outputUnitDescription);
    AudioComponentInstanceNew(outputComponent, &outputUnit);
    AudioUnitInitialize(outputUnit);
    
    
    AudioStreamBasicDescription ASBD =
    {
        .mSampleRate       = 44100,
        .mFormatID         = kAudioFormatLinearPCM,
        .mFormatFlags      = kAudioFormatFlagsNativeFloatPacked,
        .mChannelsPerFrame = 1,
        .mFramesPerPacket  = 1,
        .mBitsPerChannel   = sizeof(Float32) * 8,
        .mBytesPerPacket   = sizeof(Float32),
        .mBytesPerFrame    = sizeof(Float32)
    };
    
    AudioUnitSetProperty(outputUnit,
                         kAudioUnitProperty_StreamFormat,
                         kAudioUnitScope_Input,
                         0,
                         &ASBD,
                         sizeof(ASBD)
                         );
    
    AURenderCallbackStruct callbackInfo =
    {
        .inputProc       = SineWaveRenderCallback,
        .inputProcRefCon = &callBackSupport      // &renderPhase
    };
    
    AudioUnitSetProperty(outputUnit,
                         kAudioUnitProperty_SetRenderCallback,
                         kAudioUnitScope_Global,
                         0,
                         &callbackInfo,
                         sizeof(callbackInfo)
                         );
    
    // we take the followng outside later 
    // AudioOutputUnitStart(outputUnit);
}


-(void)start
{
    AudioOutputUnitStart(outputUnit);
}





OSStatus SineWaveRenderCallback(void * inRefCon,
                                AudioUnitRenderActionFlags * ioActionFlags,
                                const AudioTimeStamp * inTimeStamp,
                                UInt32 inBusNumber,
                                UInt32 inNumberFrames,
                                AudioBufferList * ioData)
{
    // inRefCon is the context pointer we passed in earlier when setting the render callback
    // double currentPhase = *((double *)inRefCon);
    struct CallBackSupportStructure currentStructure;
    
    currentStructure = *(struct CallBackSupportStructure*)inRefCon;
    
    
    // ioData is where we're supposed to put the audio samples we've created
    
    Float32 * outputBuffer = (Float32 *)ioData->mBuffers[0].mData;
    
    
    
    for(int i = 0; i < inNumberFrames; i++)
    {
        
        
        if(currentStructure.myPointer < currentStructure.bufSize * currentStructure.speed)
        {
            outputBuffer[i] = currentStructure.myBuffer[currentStructure.myPointer];
        }
        else
        {
            outputBuffer[i] = 0.0;
            currentStructure.runFlag = 0;
            // myPointer = 0;
        }
        
        
        
        currentStructure.myPointer = currentStructure.myPointer + 1;
        
        
    }
    
    // If we were doing stereo (or more), this would copy our sine wave samples
    // to all of the remaining channels
    
    for(int i = 1; i < ioData->mNumberBuffers; i++)
    {
        memcpy(ioData->mBuffers[i].mData, outputBuffer, ioData->mBuffers[i].mDataByteSize);
    }
    
    // writing the current phase back to inRefCon so we can use it on the next call
    *((struct CallBackSupportStructure *)inRefCon) = currentStructure;
    
    
    return noErr;
    
}







-(void)createSound
{
   // NSString* code;
   // code = @"--.-";
    
    // callBackSupport.speed  = 10000;
    
    callBackSupport.myPointer = 0;
    
    callBackSupport.runFlag = 1;
    
    double currentPhase = 0.0;
    
    
    double phaseStep = (callBackSupport.frequency / 44100.) * (M_PI * 2.);
    
    
    
    // calculate buffer size
    
    callBackSupport.bufSize = 0;  // add waiting time to the start ! // was 0
    
    for(int i = 0 ; i < [code length]; i++)
    {
        char c = [code characterAtIndex:i];
        
        if (c == '.')
        {
            callBackSupport.bufSize +=1;
        }
        if(c == '-')
        {
            callBackSupport.bufSize += 3;
        }
        
        if(c == ' ')
        {
            callBackSupport.bufSize += 3;
        }
        
        
       // NSLog(@"bufsize: %i", callBackSupport.bufSize);
        
    }
    
    callBackSupport.bufSize = callBackSupport.bufSize + (int)[code length]; // add empty spaces
    
    // NSLog(@"finbufsize: %i", callBackSupport.bufSize);
    
    
    callBackSupport.myBuffer =
    (Float32*)malloc( callBackSupport.bufSize * callBackSupport.speed * sizeof(Float32));
    
    
    
    
    int run;
    run = 0;
    int j;
    j = 0;
    
    // r  = 0;
    
    
    
    
    for(int i = 0; i < [code length]; i++)
    {
        
        char c = [code characterAtIndex:i];
        
        
        
        int runLength;
        runLength = 0;
        
        if(c==' ')
        {
            runLength = 3*callBackSupport.speed;
        }
        
        if(c =='.')
        {
            runLength = 1*callBackSupport.speed;
        }
        
        if(c == '-')
        {
            runLength = 3*callBackSupport.speed;
        }
        
        
        float ramp = 0.0;
        
        for(j = run; j < run + runLength ; j++)
        {
            
            if((ramp < 1.0) && (j < run + 12))
            {
                ramp += 0.1;
            }
            if((ramp > 0.0) && (j > run + runLength - 12))
            {
                ramp -= 0.1;
            }
            if(c== ' ')
            {
                
                ramp = 0.0; 
            }
               
            callBackSupport.myBuffer[j] = ramp*sin(currentPhase);
            currentPhase += phaseStep;
            
        }
        
        
        
        run = run+runLength;
        
        for(j = run; j < run + 1*callBackSupport.speed ; j++)
        {
            
            callBackSupport.myBuffer[j] = 0.0;
            currentPhase += phaseStep;
        }
        
        run = run + callBackSupport.speed;
        
        
    }
    
    
    
}


-(void)setSpeed:(int) s
{
    // NSLog(@"speed in AC : %i ", s);
    
    callBackSupport.speed = s;
}
               
 
-(void)setFrequency:(double) f
{
    callBackSupport.frequency = f;
}

-(void)setCode:(NSString*) c
{
    code = c;
}



//check run delay if cbg == true else stop immediately

-(bool)stop:(bool) cbf
{
    

   bool stopFlag;
   stopFlag = true;
    
    
    if((callBackSupport.runFlag == 1) && (cbf))
    {
       stopFlag = false;
    }
    else
    {
       stopFlag = true;  // this is exit condition ?
    }
           
    
    if(stopFlag == true)
    {
    	AudioOutputUnitStop(outputUnit);
    }
    
    return stopFlag;
}


- (void)terminate: (int) x
{
    
    while(callBackSupport.runFlag == 1)
    {
        //NSLog(@";;;;");
    }
    
  //  AudioOutputUnitStop(outputUnit);
    AudioUnitUninitialize(outputUnit);
    AudioComponentInstanceDispose(outputUnit);
    
}

@end




