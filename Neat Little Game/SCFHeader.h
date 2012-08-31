//
//  SCFHeader.h
//  Neat Little Game
//
//  Created by Christopher Sierigk on 19.05.12.
//  Copyright (c) 2012 DerRM Productions. All rights reserved.
//

#ifndef Neat_Little_Game_SCFHeader_h
#define Neat_Little_Game_SCFHeader_h

class SCFHeader
{
public:
    class SCFMainChunk
    {
    public:
        SCFMainChunk(){};
        ~SCFMainChunk(){};
        
        int magicNumber;
        int version;
        int chunkId;
        int noSubChunks;
    };
    
    class SCFGeometryHeader
    {
    public:
        SCFGeometryHeader(){};
        ~SCFGeometryHeader(){};
            
        int chunkId;
        int noOfTriangleGroups;
        int noOfTriangles;
        int dataOffset;
    };
};

#endif
