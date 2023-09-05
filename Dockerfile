# -----------------
FROM composer:2.5.8@sha256:e7c09c4a0a7da91ace539fe8c382afbc7b2ed6b8702a64df0dd33686685ef3c7 AS build-env

COPY . /opt/ghsec-jira/

WORKDIR /opt/ghsec-jira

RUN composer install --prefer-dist --no-dev

# -----------------
FROM php:8.2.10-alpine3.18@sha256:b5884ca8bf409cf571b321143ff30cfea16b9abab7245b9742343d3eee4abf3b

COPY --from=build-env /opt/ghsec-jira/ /opt/ghsec-jira/

ENTRYPOINT ["/opt/ghsec-jira/bin/ghsec-jira", "sync"]
