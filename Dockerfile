FROM ubuntu:22.04

ARG TEXLIVE_VERSION=2022

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS=yes
ENV PATH="/usr/local/texlive/bin:$PATH"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        make \
        wget \
        python3 \
        libfontconfig1-dev \
        libfreetype6-dev \
        ghostscript \
        perl \
        git \
        poppler-utils \
        ttf-mscorefonts-installer && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        python3-pip \
        python3-dev && \
    echo 'y' | cpan YAML/Tiny.pm Log::Dispatch::File File::HomeDir Unicode::GCString && \
    pip3 install --no-cache-dir pygments && \
    mkdir /tmp/install-tl-unx && \
    wget -O - ftp://tug.org/historic/systems/texlive/${TEXLIVE_VERSION}/install-tl-unx.tar.gz \
        | tar -xzv -C /tmp/install-tl-unx --strip-components=1 && \
    /bin/echo -e 'selected_scheme scheme-basic\ntlpdbopt_install_docfiles 0\ntlpdbopt_install_srcfiles 0' \
        > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
        --profile /tmp/install-tl-unx/texlive.profile && \
    rm -r /tmp/install-tl-unx && \
    ln -sf /usr/local/texlive/${TEXLIVE_VERSION}/bin/$(uname -m)-linux /usr/local/texlive/bin && \
    apt-get remove -y --purge \
        build-essential && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN tlmgr option repository ctan && \
    tlmgr update --self && \
    tlmgr install \
        collection-bibtexextra \
        collection-fontsrecommended \
        collection-langenglish \
        collection-langjapanese \
        collection-latexextra \
        collection-latexrecommended \
        collection-luatex \
        collection-mathscience \
        collection-plaingeneric \
        collection-xetex \
        latexmk \
        latexdiff \
        siunitx \
        latexindent && \
    wget https://raw.githubusercontent.com/being24/plistings/master/plistings.sty && \
    mv plistings.sty /usr/local/texlive/${TEXLIVE_VERSION}/texmf-dist/tex/latex/listing && \
    chmod +r /usr/local/texlive/${TEXLIVE_VERSION}/texmf-dist/tex/latex/listing/plistings.sty && \
    mktexlsr

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        npm && \
    npm install -g textlint \
        textlint-rule-preset-ja-technical-writing \
        textlint-rule-preset-ja-spacing \
        textlint-rule-no-mix-dearu-desumasu \
        textlint-filter-rule-comments \
        textlint-filter-rule-allowlist \
        textlint-plugin-html \
        textlint-plugin-latex2e && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workdir
