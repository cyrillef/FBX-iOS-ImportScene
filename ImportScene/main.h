/****************************************************************************************
 
 Copyright (C) 2014 Autodesk, Inc.
 All rights reserved.
 
 Use of this software is subject to the terms of the Autodesk license agreement
 provided at the time of installation or download, or which otherwise accompanies
 this software in either electronic or hard copy form.
 
 ****************************************************************************************/

#ifndef _MAIN_H
#define _MAIN_H

extern bool gVerbose ;

int xx__main__xx (FbxString &lFilePath) ;
void DisplayMetaData (FbxScene *pScene) ;
void DisplayContent (FbxScene *pScene) ;
void DisplayContent (FbxNode *pNode) ;
void DisplayTarget (FbxNode *pNode) ;
void DisplayTransformPropagation (FbxNode *pNode) ;
void DisplayGeometricTransform (FbxNode *pNode) ;

#include "DisplayCommon.h"
#include "DisplayHierarchy.h"
#include "DisplayAnimation.h"
#include "DisplayMarker.h"
#include "DisplaySkeleton.h"
#include "DisplayMesh.h"
#include "DisplayNurb.h"
#include "DisplayPatch.h"
#include "DisplayLodGroup.h"
#include "DisplayCamera.h"
#include "DisplayLight.h"
#include "DisplayGlobalSettings.h"
#include "DisplayPose.h"
#include "DisplayPivotsAndLimits.h"
#include "DisplayUserProperties.h"
#include "DisplayGenericInfo.h"

#endif // #ifndef _MAIN_H

