// (C) Copyright 2014 by Autodesk, Inc.
//
// Permission to use, copy, modify, and distribute this software in
// object code form for any purpose and without fee is hereby granted,
// provided that the above copyright notice appears in all copies and
// that both that copyright notice and the limited warranty and
// restricted rights notice below appear in all supporting
// documentation.
//
// AUTODESK PROVIDES THIS PROGRAM "AS IS" AND WITH ALL FAULTS.
// AUTODESK SPECIFICALLY DISCLAIMS ANY IMPLIED WARRANTY OF
// MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.  AUTODESK, INC.
// DOES NOT WARRANT THAT THE OPERATION OF THE PROGRAM WILL BE
// UNINTERRUPTED OR ERROR FREE.

//- Written by Cyrille Fauvel, Autodesk Developer Network (ADN)
//- http://www.autodesk.com/joinadn
//- July 2nd, 2014
//
#pragma once

#import <Foundation/Foundation.h>

#import "fbxsdk.h"
#import "main.h"
//#import "Common.h"

#define PropToTextCtrl(ctrl,fst,st) \
	ctrl.text =[[NSString alloc] initWithFormat:fst, st.Buffer ()] ;

@interface NSFbxObject : NSObject {
	@public
	FbxManager *_sdkManager ;
	FbxScene *_scene ;
}

- (id)init ;
- (id)initWithFile:(NSString *)filename ;
- (void)dealloc ;

//- (void)Initialize ;
//- (void)Terminate ;

- (BOOL)LoadScene:(NSString *)filename ;

@end
