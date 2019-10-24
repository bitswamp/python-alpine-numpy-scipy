### python-alpine-numpy-scipy

Not intended for general use. This image builds on `python:3.7-alpine` and includes specific versions of `numpy` and `scipy` for use in another project.

The image is created with a two-stage Dockerfile so that the final image does not include the dev toolchain including `musl-dev`, `openblas-dev`, `g++` and dependencies.
