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
#import "NSFbxObject.h"
#import "Common.h"

@implementation NSFbxObject

- (id)init {
	if ( (self =[super init]) ) {
		[self Initialize] ;
	}
	return (self) ;
}

- (id)initWithFile:(NSString *)filename {
	if ( (self =[super init]) ) {
		[self Initialize] ;
		[self LoadScene:filename] ;
	}
	return (self) ;
}

- (void)dealloc {
	[self Terminate] ;
	//[super dealloc] ;
}

- (void)Initialize {
	// Prepare the FBX SDK.
    InitializeSdkObjects (_sdkManager, _scene) ;
}

- (void)Terminate {
	bool bResult ;
	DestroySdkObjects (_sdkManager, bResult) ;
}

- (BOOL)LoadScene:(NSString *)filename {
	FbxString fbxSt ([filename cStringUsingEncoding:[NSString defaultCStringEncoding]]) ;
	bool bResult =LoadScene (_sdkManager, _scene, fbxSt.Buffer ()) ;
	return (bResult) ;
}

@end
