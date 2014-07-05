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
#import "FileStructureController.h"
#import "MetadataViewController.h"
#import "GenericViewController.h"

@interface FileStructureController () {
	NSIndexPath *_selectedRowIndex ;
}

@end

@implementation FileStructureController

@synthesize _filename =__filename ;
@synthesize _fbxStructure =__fbxStructure ;
@synthesize _fbxObject =__fbxObject ;

- (void)viewDidLoad {
    [super viewDidLoad] ;
	self._fbxStructure =[[NSMutableArray alloc] initWithObjects:
						 @"Meta Data",
						 @"Global Light Settings",
						 @"Global Camera Settings",
						 @"Global Time Settings",
						 @"Hierarchy",
						 @"Node Content",
						 @"Pose",
						 @"Animation",
						 @"Generic Information",
						 nil] ;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated] ;
	
	NSString *st =self._filename ;
	if ( ![[NSFileManager defaultManager] fileExistsAtPath:st] )
		st =[[NSBundle mainBundle] pathForResource:[[self._filename lastPathComponent] stringByDeletingPathExtension] ofType:[self._filename pathExtension]] ;
	self._fbxObject =[[NSFbxObject alloc] initWithFile:st] ;
	
	//FbxString fbxSt ([st cStringUsingEncoding:[NSString defaultCStringEncoding]]) ;
	//xx__main__xx (fbxSt) ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning] ;
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	//NSIndexPath *ip =[self.tableView indexPathForCell:sender] ;
    if ( [[segue identifier] isEqualToString:@"MetadataSegues"] ) {
		MetadataViewController *vc =[segue destinationViewController] ;
		vc._fbxObject =self._fbxObject ;
    }
	if ( [[segue identifier] isEqualToString:@"GenericSegues"] ) {
		GenericViewController *vc =[segue destinationViewController] ;
		vc._fbxObject =self._fbxObject ;
		vc._what =_selectedRowIndex.row ;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return (1) ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return (self._fbxStructure.count) ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"StructureCell" ;
	UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
	NSString *sectionName =[self._fbxStructure objectAtIndex:indexPath.row] ;
	[cell.textLabel setText:sectionName] ;
	//[cell.detailTextLabel setText:@"???"] ;
    return (cell) ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	_selectedRowIndex =indexPath ;
	if ( indexPath.row == 0 )
		[self performSegueWithIdentifier:@"MetadataSegues" sender:self._fbxObject] ;
	else
		[self performSegueWithIdentifier:@"GenericSegues" sender:self._fbxObject] ;
}

@end
