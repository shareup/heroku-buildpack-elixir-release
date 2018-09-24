FROM heroku/heroku:16

RUN apt-get update

RUN apt-get install -y \
  curl wget ca-certificates \
  gcc g++ \
  make automake autoconf \
  libwxgtk3.0-dev libgl1-mesa-dev libglu1-mesa-dev libpng3 \
  libreadline-dev libncurses-dev libssl-dev libssh-dev \
  libxslt-dev libffi-dev libtool unixodbc-dev \
  fop xsltproc

RUN mkdir -p /home/builderl

ARG OTP_VERSION

ENV URL="https://github.com/erlang/otp/archive/OTP-${OTP_VERSION}.tar.gz"
ENV DOWNLOAD_TARPATH="/home/download-OTP-${OTP_VERSION}.tar.gz"
ENV COMPILED_TARPATH="/home/OTP-${OTP_VERSION}.tar.gz"

RUN curl -L "${URL}" -o "${DOWNLOAD_TARPATH}"
RUN tar xzf "${DOWNLOAD_TARPATH}" -C /home/builderl --strip-components=1

WORKDIR /home/builderl

RUN ./otp_build autoconf && \
  ./configure --with-ssl --enable-dirty-schedulers && \
  make && \
  make release && \
  tar zcf "${COMPILED_TARPATH}" /home/builderl/release/x86_64-unknown-linux-gnu/

ENV PATH="/home/builderl/bin/:$PATH"

CMD /bin/bash
