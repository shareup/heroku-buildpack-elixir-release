FROM heroku/heroku:18-build

RUN apt-get update

ENV DEBIAN_FRONTEND="noninteractive"

RUN mkdir -p /home/builderl

ARG OTP_VERSION

ENV URL="https://github.com/erlang/otp/archive/OTP-${OTP_VERSION}.tar.gz"
ENV DOWNLOAD_TARPATH="/home/download-OTP-${OTP_VERSION}.tar.gz"
ENV COMPILED_TARPATH="/home/OTP-${OTP_VERSION}.tar.gz"

RUN curl -f -L "${URL}" -o "${DOWNLOAD_TARPATH}"
RUN tar xf "${DOWNLOAD_TARPATH}" -C /home/builderl --strip-components=1

WORKDIR /home/builderl

RUN ./otp_build autoconf

RUN ./configure --build="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"

RUN make -j$(nproc)
RUN make release

RUN tar cf "${COMPILED_TARPATH}" -C /home/builderl/release/x86_64-pc-linux-gnu/ .

ENV PATH="/home/builderl/bin/:$PATH"

CMD /bin/bash
