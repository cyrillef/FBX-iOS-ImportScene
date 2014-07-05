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
#import "SceneFilesController.h"
#import "FileStructureController.h"

@interface SceneFilesController ()

@end

@implementation SceneFilesController

@synthesize _fbx =__fbx ;

- (void)viewDidLoad {
    [super viewDidLoad] ;
	// Add Bundle default file
	self._fbx =[[NSMutableArray alloc] init] ;
	[self._fbx addObject:@"humanoid.fbx"] ;
	// Add any other we installed on the device
	
	NSFileManager *fileManager =[[NSFileManager alloc] init] ;
	NSArray *paths =NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) ;
	NSString *documentsPath =[paths objectAtIndex:0] ;
	NSDirectoryEnumerator *fileEnumerator =[fileManager enumeratorAtPath:documentsPath] ;
	for ( NSString *filename in fileEnumerator ) {
		if (   [[filename pathExtension] isEqualToString:@"fbx"] == YES
			|| [[filename pathExtension] isEqualToString:@"obj"] == YES
		) {
			[self._fbx addObject:filename] ;
		}
	}
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning] ;
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ( [[segue identifier] isEqualToString:@"FileStructureSegues"] ) {
        FileStructureController *vc =[segue destinationViewController] ;
        NSIndexPath *ip =[self.tableView indexPathForSelectedRow] ;
        vc._filename =[self._fbx objectAtIndex:ip.row] ;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return (1) ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return (self._fbx.count) ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"SectionCell" ;
	UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
	NSString *sceneName =[self._fbx objectAtIndex:indexPath.row] ;
	[cell.textLabel setText:sceneName] ;
	//[cell.detailTextLabel setText:@"???"] ;
    return (cell) ;
}

@end
