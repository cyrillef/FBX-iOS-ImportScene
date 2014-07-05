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
#import "MetadataViewController.h"

@interface MetadataViewController () {
	IBOutlet UILabel *_title ;
	IBOutlet UILabel *_subject ;
	IBOutlet UILabel *_author ;
	IBOutlet UILabel *_keywords ;
	IBOutlet UILabel *_revision ;
	IBOutlet UILabel *_comment ;
	IBOutlet UISwitch *_thumbnail ;
	IBOutlet UILabel *_rgbMode ;
	IBOutlet UILabel *_size ;
}

@end

@implementation MetadataViewController

@synthesize _fbxObject =__fbxObject ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ( (self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) ) {
        // Custom initialization
    }
    return (self) ;
}

- (void)viewDidLoad {
    [super viewDidLoad] ;
    
	FbxScene *pScene =self._fbxObject->_scene ;
	DisplayMetaData (pScene) ;
	
	FbxDocumentInfo *sceneInfo =pScene->GetSceneInfo () ;
    if ( sceneInfo ) {
		_title.text =[[NSString alloc] initWithFormat:@"Title: %s", sceneInfo->mTitle.Buffer ()] ;
		//PropToTextCtrl (_title, @"Title: %s", sceneInfo->mTitle) ;
		PropToTextCtrl (_subject, @"Subject: %s", sceneInfo->mSubject) ;
		PropToTextCtrl (_author, @"Author: %s", sceneInfo->mAuthor) ;
		PropToTextCtrl (_keywords, @"Keywords: %s", sceneInfo->mKeywords) ;
		PropToTextCtrl (_revision, @"Revision: %s", sceneInfo->mRevision) ;
		PropToTextCtrl (_comment, @"Comment: %s", sceneInfo->mComment) ;
		
		FbxThumbnail *thumbnail =sceneInfo->GetSceneThumbnail () ;
		[_thumbnail setOn:NO] ;
        if ( thumbnail ) {
			[_thumbnail setOn:YES] ;
            switch ( thumbnail->GetDataFormat () ) {
				case FbxThumbnail::eRGB_24:
					_rgbMode.text =@"RGB" ;
					break ;
				case FbxThumbnail::eRGBA_32:
					_rgbMode.text =@"RGBA" ;
					break ;
            }
            switch ( thumbnail->GetSize () ) {
				default:
					_size.text =@"" ;
					break ;
				case FbxThumbnail::eNotSet:
					_size.text =[[NSString alloc] initWithFormat:@"no dimensions specified (%ld bytes)", thumbnail->GetSizeInBytes ()] ;
					break ;
				case FbxThumbnail::e64x64:
					_size.text =[[NSString alloc] initWithFormat:@"64 x 64 pixels (%ld bytes)", thumbnail->GetSizeInBytes ()] ;
					break ;
				case FbxThumbnail::e128x128:
					_size.text =[[NSString alloc] initWithFormat:@"128 x 128 pixels (%ld bytes)", thumbnail->GetSizeInBytes ()] ;
					break ;
            }
        }
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning] ;
    // Dispose of any resources that can be recreated.
}

@end
