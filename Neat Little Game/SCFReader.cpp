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
}

SCFReader::SCFReader(const char* fileName)
{
    read(fileName);
}

void SCFReader::read(const char* filename)
{
    ifstream myFile;
    myFile.open(filename, ios::binary);
    
    if (myFile.is_open())
    {
        myFile.read((char*) &mainHeader, sizeof(SCFHeader::SCFMainChunk));
        
        myFile.read((char*) &geometryHeader, sizeof(SCFHeader::SCFGeometryHeader));
        
        int noFloatsPosition;
        myFile.read((char*) &noFloatsPosition, sizeof(int));
        
        float* floatData= new float[noFloatsPosition];
        
        for (int i = 0; i < noFloatsPosition; i++)
        {
            myFile.read((char*) &floatData[i], sizeof(float));
        }
        
        int noFloatsNormals;
        myFile.read((char*) &noFloatsNormals, sizeof(int));
        
        float* floatNormals = new float[noFloatsNormals];
        
        for (int i = 0; i < noFloatsNormals; i++)
        {
            myFile.read((char*) &floatNormals[i], sizeof(float));
        }
        
        int noTriangles;
        myFile.read((char*) &noTriangles, sizeof(int));
        
        short* triangleIndices = new short[noTriangles * 3];
        short* triangleNormals = new short[noTriangles * 3];
        
        for (int i = 0; i < noTriangles; i += 3)
        {
            myFile.read((char*) &triangleIndices[i], sizeof(short));
            myFile.read((char*) &triangleIndices[i + 1], sizeof(short));
            myFile.read((char*) &triangleIndices[i + 2], sizeof(short));

            myFile.read((char*) &triangleNormals[i], sizeof(short));
            myFile.read((char*) &triangleNormals[i + 1], sizeof(short));
            myFile.read((char*) &triangleNormals[i + 2], sizeof(short));
        }
        
        cout << "MagicNumber: " << mainHeader.magicNumber << endl;
        cout << "Version: " << mainHeader.version << endl;
        cout << "ChunkID: " << mainHeader.chunkId << endl;
        cout << "Number of SubChunks: " << mainHeader.noSubChunks << endl;
        
        cout << "ChunkID: " << geometryHeader.chunkId << endl;
        cout << "NoTriangleGroups: " << geometryHeader.noOfTriangleGroups << endl;
        cout << "TotalNoTriangles: " << geometryHeader.noOfTriangles << endl;
        cout << "DataOffset: " << geometryHeader.dataOffset << endl;
        
        cout << "MagicNumber: " << floatData[0] << endl;
        cout << "MagicNumber: " << floatNormals[1] << endl;
        cout << "NoTriangles: " << noTriangles << endl;
        cout << "Index 1: " << triangleIndices[0] << endl;
        cout << "Index 2: " << triangleIndices[1] << endl;
        cout << "Index 3: " << triangleIndices[2] << endl;
        cout << "Index 4: " << triangleIndices[3] << endl;
        cout << "Index 5: " << triangleIndices[4] << endl;
        cout << "Index 6: " << triangleIndices[5] << endl;
        cout << "Index 1: " << triangleNormals[0] << endl;
        cout << "Index 2: " << triangleNormals[1] << endl;
        cout << "Index 3: " << triangleNormals[2] << endl;
        cout << "Index 4: " << triangleNormals[3] << endl;
        cout << "Index 5: " << triangleNormals[4] << endl;
        cout << "Index 6: " << triangleNormals[5] << endl;

    } else {
        cout << "Can't open file" << endl;
    }
    
}

int SCFReader::test()
{
    return 234;
}