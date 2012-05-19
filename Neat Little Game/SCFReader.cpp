//
//  SCFReader.cpp
//  Neat Little Game
//
//  Created by Christopher Sierigk on 01.05.12.
//  Copyright (c) 2012 DerRM Productions. All rights reserved.
//

#include "SCFReader.h"

SCFReader::SCFReader()
{
    read();
}

SCFReader::SCFReader(char* fileName)
: fileName(fileName)
{
    
}

void SCFReader::read()
{
    ifstream myFile;
    myFile.open("Test.scf", ios::binary);
    
    if (myFile.is_open())
    {
        myFile.read((char*) &header, sizeof(Header));
        
        Header header2;
        myFile.read((char*) &header2, sizeof(Header));
        
        int test;
        myFile.read((char*) &test, sizeof(int));
        
        float test2;
        myFile.read((char*) &test2, sizeof(float));
        
        cout << "MagicNumber: " << header.magicNumber << endl;
        cout << "Version: " << header.version << endl;
        cout << "ChunkID: " << header.chunkId << endl;
        cout << "Number of SubChunks: " << header.noOfSubChunks << endl;
        
        cout << "MagicNumber: " << header2.magicNumber << endl;
        cout << "Version: " << header2.version << endl;
        cout << "ChunkID: " << header2.chunkId << endl;
        cout << "Number of SubChunks: " << header2.noOfSubChunks << endl;
        
        cout << "MagicNumber: " << test << endl;
        cout << "MagicNumber: " << test2 << endl;

    } else {
        cout << "Can't open file" << endl;
    }
    
}

int SCFReader::test()
{
    return 234;
}