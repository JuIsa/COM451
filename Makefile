
# CUDA includes and libraries
F1= -L/usr/local/cuda-10.1/lib64
F2= -I/usr/local/cuda-10.1/targets/x86_64-linux/include -lcuda -lcudart

# F1= -L/usr/local/cuda/lib64
# F2= -I/usr/local/cuda-9.2/targets/x86_64-linux/include -lcuda -lcudart

# My laptop includes
# F1= -L/usr/bin/lib64
# F2= -I/usr/bin/targets/x86_64-linux/include -lcuda -lcudart

# SDL shtuff (for sound processing)
#F3= -I/usr/local/include -L/usr/local/lib -lSDL2
F4= -std=c++11
#F4= -std=c++14

# animation libraries:
F5= -lglut -lGL

# parallel threading
F6= -pthread

all: MyViz

MyViz: interface.o PDP1_Zhanboloti.o PDP2_Zhanboloti.o animate.o gpu_main.o
	g++ -o MyViz interface.o PDP1_Zhanboloti.o PDP2_Zhanboloti.o gpu_main.o animate.o $(F1) $(F2) $(F3) $(F4) $(F5) $(F6)

# do we really need all these flags to compile interface??!!
interface.o: interface.cpp PDP2_Zhanboloti.cpp gpu_main.cu animate.cu
	g++ -w -c interface.cpp $(F1) $(F2)
	
PDP2_Zhanboloti.o: PDP2_Zhanboloti.cpp gpu_main.cu animate.cu
	g++ -w -c PDP2_Zhanboloti.cpp $(F1) $(F2)

PDP1_Zhanboloti.o: PDP1_Zhanboloti.cpp
	g++ -w -c PDP1_Zhanboloti.cpp

gpu_main.o: gpu_main.cu
	nvcc -w -c gpu_main.cu

animate.o: animate.cu
	nvcc -w -c animate.cu
#	nvcc -w -c animate.cu $(ANIMLIBS)

#audio.o: audio.c audio.h
#	g++ -w -c audio.c $(F2)

clean:
	rm *.o MyViz
