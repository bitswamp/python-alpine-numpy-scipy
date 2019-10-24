# stage 1 - build wheels
FROM python:3.7-alpine AS build-wheel
ENV PYTHONUNBUFFERED=1

# dependencies to build numpy and scipy
RUN apk add --update --no-cache musl-dev openblas-dev g++

ARG NUMPY_VERSION=1.16.2
RUN pip wheel -w /wheel numpy==${NUMPY_VERSION}

ARG SCIPY_VERSION=1.2.1
# scipy needs numpy installed
RUN pip install --no-index --find-links=/wheel numpy
RUN pip wheel -w /wheel scipy==${SCIPY_VERSION}

# stage 2 - install wheels
FROM python:3.7-alpine AS install-wheel
ENV PYTHONUNBUFFERED=1

COPY --from=build-wheel /wheel /wheel

RUN apk add --update --no-cache libstdc++ openblas

RUN pip install --no-index --find-links=/wheel numpy scipy

RUN pip install pytest
RUN python -c 'import numpy; numpy.test()'
RUN python -c 'import scipy; scipy.test();'
