FROM debian:bookworm-slim

# Keep this Dockerfile simple and readable. It installs build deps, compiles the
# C game (SDL 1.2 style), and exposes a tiny healthcheck via the binary's --health flag.
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		build-essential \
		gcc \
		libsdl1.2-dev \
		libsmpeg-dev \
		libsdl-image1.2-dev \
		libsdl-ttf2.0-dev \
		libsdl-gfx1.2-dev \
		wget \
		python3 \
		python3-pip \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

# Install Python deps for ai_model.py (optional, small and explicit)
RUN pip3 install --no-cache-dir joblib scikit-learn numpy || true

# Build the game binary using the project's C sources. Keep the command obvious.
RUN gcc *.c -o GAME -g -lm -lSDL -lSDL_image -lSDL_gfx -lSDL_ttf || true

# Healthcheck uses the binary with --health. Keep it simple so you can read it later.
HEALTHCHECK --interval=30s --timeout=3s CMD ./GAME --health || exit 1

EXPOSE 8080
CMD ["./GAME"]
