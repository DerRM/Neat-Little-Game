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

using namespace std;

class SCFReader
{
    public:
    
        struct Header
        {
            int magicNumber;
            int version;
            int chunkId;
            int noOfSubChunks;
            
        } header;
    
        SCFReader();
        SCFReader(char* fileName);
        int test();
    private:
        void read();
        char* fileName;
};

#endif
