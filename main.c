
#include "Header.h"
#include <stdio.h>
#include <string.h>

SDL_Surface* screen = NULL;

int main(int argc, char** argv)
{
	if (argc > 1) {
		if (strcmp(argv[1], "--health") == 0) {
			return 0;
		}
		if (strcmp(argv[1], "--ai-test") == 0) {
			FILE *fp = popen("python3 ai_model.py '[1, 0, 10]'", "r");
			if (fp) {
				int move = -1;
				if (fscanf(fp, "%d", &move) == 1) {
					printf("AI Move: %d\n", move);
				}
				pclose(fp);
			} else {
				printf("Failed to run AI model\n");
			}
			return 0;
		}
	}

	initEverything();
	loadLevels();
	paintMenu(screen);
	closeEverything();
	return 0;
}



void initEverything()
{
	SDL_Init(SDL_INIT_EVERYTHING);
	TTF_Init();
	//Mix_Init(MIX_INIT_MP3);
	IMG_Init(IMG_INIT_JPG | IMG_INIT_PNG);
	screen = SDL_SetVideoMode(800, 600, 0, SDL_HWSURFACE);
	SDL_WM_SetCaption("Wizards of War", NULL);
}
/**
 * Clean everything before we exit the game
 */
void closeEverything()
{
	//atexit(Mix_Quit);
	atexit(IMG_Quit);
	atexit(TTF_Quit);
	atexit(SDL_Quit);
}