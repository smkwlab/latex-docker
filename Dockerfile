FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS=yes

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ssh \
        git \
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
