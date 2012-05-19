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
    class SCFMainChunk
    {
        public:
            SCFMainChunk();
            ~SCFMainChunk();
        
            int magicNumber;
            int version;
            int chunkId;
            int noSubChunks;
    };
};

#endif
