game: *.c
	gcc *.c -lm -lSDL -lSDL_image -lSDL_gfx -lSDL_ttf -lSDL_mixer -o GAME -g

.PHONY: run
run: game
	./GAME
