CCFLAGS = -fPIC -c -O3 -ffast-math -fexpensive-optimizations
CCFLAGS_DEBUG = -c -g -DJSON_SAFE -DJSON_DEBUG
CCFLAGS_SMALL = -c -Os -ffast-math -DJSON_LESS_MEMORY

default:
	rm -r Objects
	-mkdir Objects
	g++ Source/internalJSONNode.cpp -o Objects/internalJSONNode.o $(CCFLAGS)
	g++ Source/JSON_Base64.cpp -o Objects/JSON_Base64.o $(CCFLAGS)
	g++ Source/JSONChildren.cpp -o Objects/JSONChildren.o $(CCFLAGS)
	g++ Source/JSONDebug.cpp -o Objects/JSONDebug.o $(CCFLAGS)
	g++ Source/JSONIterators.cpp -o Objects/JSONIterators.o $(CCFLAGS)
	g++ Source/JSONMemory.cpp -o Objects/JSONMemory.o $(CCFLAGS)
	g++ Source/JSONNode_Mutex.cpp -o Objects/JSONNode_Mutex.o $(CCFLAGS)
	g++ Source/JSONNode.cpp -o Objects/JSONNode.o $(CCFLAGS)
	g++ Source/JSONWorker.cpp -o Objects/JSONWorker.o $(CCFLAGS)
	g++ Source/JSONWriter.cpp -o Objects/JSONWriter.o $(CCFLAGS)
	g++ Source/libjson.cpp -o Objects/libjson.o $(CCFLAGS)
	
	g++ -o libjson.so -shared Objects/internalJSONNode.o Objects/JSON_Base64.o \
	Objects/JSONChildren.o Objects/JSONDebug.o \
	Objects/JSONIterators.o Objects/JSONMemory.o \
	Objects/JSONNode_Mutex.o Objects/JSONNode.o \
	Objects/JSONWorker.o Objects/JSONWriter.o \
	Objects/libjson.o

debug:
	rm -r Objects
	-mkdir Objects
	g++ Source/internalJSONNode.cpp -o Objects/internalJSONNode.o $(CCFLAGS_DEBUG)
	g++ Source/JSON_Base64.cpp -o Objects/JSON_Base64.o $(CCFLAGS_DEBUG)
	g++ Source/JSONChildren.cpp -o Objects/JSONChildren.o $(CCFLAGS_DEBUG)
	g++ Source/JSONDebug.cpp -o Objects/JSONDebug.o $(CCFLAGS_DEBUG)
	g++ Source/JSONIterators.cpp -o Objects/JSONIterators.o $(CCFLAGS_DEBUG)
	g++ Source/JSONMemory.cpp -o Objects/JSONMemory.o $(CCFLAGS_DEBUG)
	g++ Source/JSONNode_Mutex.cpp -o Objects/JSONNode_Mutex.o $(CCFLAGS_DEBUG)
	g++ Source/JSONNode.cpp -o Objects/JSONNode.o $(CCFLAGS_DEBUG)
	g++ Source/JSONWorker.cpp -o Objects/JSONWorker.o $(CCFLAGS_DEBUG)
	g++ Source/JSONWriter.cpp -o Objects/JSONWriter.o $(CCFLAGS_DEBUG)
	g++ Source/libjson.cpp -o Objects/libjson.o $(CCFLAGS_DEBUG)
	
	ar -cvq libjson_dbg.a Objects/internalJSONNode.o Objects/JSON_Base64.o \
	Objects/JSONChildren.o Objects/JSONDebug.o \
	Objects/JSONIterators.o Objects/JSONMemory.o \
	Objects/JSONNode_Mutex.o Objects/JSONNode.o \
	Objects/JSONWorker.o Objects/JSONWriter.o \
	Objects/libjson.o
	
small:
	rm -r Objects
	-mkdir Objects
	g++ Source/internalJSONNode.cpp -o Objects/internalJSONNode.o $(CCFLAGS_SMALL)
	g++ Source/JSON_Base64.cpp -o Objects/JSON_Base64.o $(CCFLAGS_SMALL)
	g++ Source/JSONChildren.cpp -o Objects/JSONChildren.o $(CCFLAGS_SMALL)
	g++ Source/JSONDebug.cpp -o Objects/JSONDebug.o $(CCFLAGS_SMALL)
	g++ Source/JSONIterators.cpp -o Objects/JSONIterators.o $(CCFLAGS_SMALL)
	g++ Source/JSONMemory.cpp -o Objects/JSONMemory.o $(CCFLAGS_SMALL)
	g++ Source/JSONNode_Mutex.cpp -o Objects/JSONNode_Mutex.o $(CCFLAGS_SMALL)
	g++ Source/JSONNode.cpp -o Objects/JSONNode.o $(CCFLAGS_SMALL)
	g++ Source/JSONWorker.cpp -o Objects/JSONWorker.o $(CCFLAGS_SMALL)
	g++ Source/JSONWriter.cpp -o Objects/JSONWriter.o $(CCFLAGS_SMALL)
	g++ Source/libjson.cpp -o Objects/libjson.o $(CCFLAGS_SMALL)
	
	ar -cvq libjson.a Objects/internalJSONNode.o Objects/JSON_Base64.o \
	Objects/JSONChildren.o Objects/JSONDebug.o \
	Objects/JSONIterators.o Objects/JSONMemory.o \
	Objects/JSONNode_Mutex.o Objects/JSONNode.o \
	Objects/JSONWorker.o Objects/JSONWriter.o \
	Objects/libjson.o