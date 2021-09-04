FROM debian
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
        && apt-get update -qq -y \
        && 2>/dev/null 1>&2 apt-get install -qq -y make cmake g++ bsdmainutils
