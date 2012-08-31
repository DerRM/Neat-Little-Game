//
//  SCFReader.h
//  Neat Little Game
//
//  Created by Christopher Sierigk on 01.05.12.
//  Copyright (c) 2012 DerRM Productions. All rights reserved.
//

#ifndef Neat_Little_Game_SCFReader_h
#define Neat_Little_Game_SCFReader_h

#include <iostream>
#include <fstream>
#include "SCFHeader.h"

using namespace std;

class SCFReader
{
    public:
    
    SCFHeader::SCFGeometryHeader geometryHeader;
    SCFHeader::SCFMainChunk mainHeader;
    
        SCFReader();
        SCFReader(const char* fileName);
        int test();
    private:
        void read(const char* fileName);
        char* fileName;
};

#endif
