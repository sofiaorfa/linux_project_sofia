# Use Ubuntu 
FROM ubuntu:22.04  

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive  

# Package and tools
RUN apt-get update && apt-get install -y \
    wget \
    iqtree2 \
    raxml-ng \
    r-base \
    ncbi-blast+ \
    curl \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*  

# Set the working directory inside the container
WORKDIR /linux_bioinformatics  

# Copy all scripts and necessary files into the container
COPY . /linux_bioinformatics/  

# Ensure all scripts are executable
RUN chmod +x scripts/*.sh  

# Set default command to open a bash shell
ENTRYPOINT ["/bin/bash"]
