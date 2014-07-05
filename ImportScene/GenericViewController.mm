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
#import "GenericViewController.h"

#include <fstream>
#include <sstream>
#include <iostream>

@interface GenericViewController () {
	IBOutlet UITextView *_text ;
}

@end

@implementation GenericViewController

@synthesize _fbxObject =__fbxObject ;
@synthesize _what =__what ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ( (self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) ) {
        // Custom initialization
    }
    return (self) ;
}

- (void)viewDidLoad {
    [super viewDidLoad] ;
	
	NSArray *paths =NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) ;
	NSString *documentsPath =[paths objectAtIndex:0] ;
	NSString *filename =[NSString stringWithFormat:@"%@/output.txt", documentsPath] ;
	FILE *fp =freopen ([filename cStringUsingEncoding:[NSString defaultCStringEncoding]], "w", stdout) ;
	
	switch ( __what ) {
		case 1: // Global Light Settings
			DisplayGlobalLightSettings (&(self._fbxObject->_scene)->GetGlobalSettings ());
			break ;
		case 2: // Global Camera Settings
			DisplayGlobalCameraSettings (&(self._fbxObject->_scene)->GetGlobalSettings ()) ;
			break ;
		case 3: // Global Time Settings
			DisplayGlobalTimeSettings (&(self._fbxObject->_scene)->GetGlobalSettings ()) ;
			break ;
		case 4: // Hierarchy
			DisplayHierarchy (self._fbxObject->_scene) ;
			break ;
		case 5: // Node Content
			DisplayContent (self._fbxObject->_scene) ;
			break ;
		case 6: // Pose
			DisplayPose (self._fbxObject->_scene) ;
			break ;
		case 7: // Animation
			DisplayAnimation (self._fbxObject->_scene) ;
			break ;
		case 8: // Generic Information
			DisplayGenericInfo (self._fbxObject->_scene) ;
			break ;
	}
	fclose (fp) ;
	
	std::ifstream txtFile ([filename cStringUsingEncoding:[NSString defaultCStringEncoding]]) ;
	std::string contents ((std::istreambuf_iterator<char>(txtFile)), std::istreambuf_iterator<char>()) ;
	_text.text =[NSString stringWithCString:contents.data () encoding:NSUTF8StringEncoding] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning] ;
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
