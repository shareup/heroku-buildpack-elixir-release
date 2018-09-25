ARG OTP_VERSION

FROM "heroku-otp-build:${OTP_VERSION}"

ARG OTP_VERSION
ARG ELIXIR_VERSION

ENV URL="https://github.com/elixir-lang/elixir/archive/v${ELIXIR_VERSION}.tar.gz"
ENV DOWNLOAD_TARPATH="/home/download-elixir-${ELIXIR_VERSION}.tar.gz"
ENV COMPILED_TARPATH="/home/elixir-${ELIXIR_VERSION}-OTP-${OTP_VERSION}.tar.gz"

RUN mkdir -p /home/buildex

RUN curl -f -L "${URL}" -o "${DOWNLOAD_TARPATH}"
RUN tar xf "${DOWNLOAD_TARPATH}" -C /home/buildex --strip-components=1

WORKDIR /home/buildex

# Elixir requires a UTF8 locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN make
RUN tar cf "${COMPILED_TARPATH}" -C /home/buildex/ .

ENV PATH="/home/buildex/bin/:$PATH"

CMD /bin/bash
