#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

float getVolume(){
	char bash_cmd[] = "echo `arecord -f S16_LE -qd 2 /tmp/volume/volt && sox /tmp/volume/volt -n stat &> /tmp/volume/volt.d && sed '4q;d' /tmp/volume/volt.d | awk '{print $3}'`";
	char buffer[1024];
	FILE *pipe;
	int len;
	pipe = popen(bash_cmd, "r");
	if (NULL == pipe) {
		perror("pipe");
		exit(1);
	}
	fgets(buffer, sizeof(buffer), pipe);
	len = strlen(buffer);
	buffer[len-1] = '\0';
	pclose(pipe);
	return atof(buffer);
}

int main(int argc, char *argv[]) {
	float threshold = 0.349829;
	if( argc <= 1){
		printf("Using default threshold: %f\n", threshold);
	}else{
		threshold = atof(argv[1]);
		printf("Using given threshold: %f\n", threshold);
	}

	struct stat st = {0};
	if (stat("/tmp/volume", &st) == -1) {
		printf("Created: /tmp/volume\n");
	    mkdir("/tmp/volume", 0700);
	}

	float countThreshold = 2;
	float list[5] = {0.0,0.0,0.0,0.0,0.0};
	unsigned short index = 0;
	float lastVolume = 0;
	unsigned short loudCount = 0;
	while(1){
		lastVolume = getVolume();
		// printf("%f\n", lastVolume);
		list[index] = lastVolume;

		loudCount = 0;
		for (int i = 0; i < 5; ++i){
			if(list[i]>threshold) loudCount++;
		}
		if( loudCount >= countThreshold ){
			list[index] = 0;
			system("paplay bark.ogg");
		}

		index = (index+1)%5;
	}

	return 0;
}
