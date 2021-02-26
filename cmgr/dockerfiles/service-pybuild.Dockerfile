# Generated from a template file. DO NOT EDIT.
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    gcc-multilib \
    python3-pip
RUN pip3 install ninja2

RUN groupadd -r app && useradd -r -d /app -g app app
RUN install -d -m 0700 /challenge

ENV PORT=5000
# End of shared layers for all flask challenges

COPY Dockerfile packages.txt* ./
RUN if [ -f packages.txt ]; then apt-get update && xargs -a packages.txt apt-get install -y; fi

COPY Dockerfile requirements.txt* ./
RUN if [ -f requirements.txt ]; then pip3 install -r requirements.txt; fi

COPY . /app
WORKDIR /app

# End of share layers for all builds of the same flask challenge

ARG FLAG_FORMAT
ARG FLAG
ARG SEED

RUN echo -n 'aW1wb3J0IG9zCmltcG9ydCByYW5kb20KaW1wb3J0IHN0YXQKCmltcG9ydCBqc29uCmltcG9ydCBqaW5qYTIKCnJhbmRvbS5zZWVkKG9zLmVudmlyb25bIlNFRUQiXSkKdHJ5OgogICAgaW1wb3J0IGJ1aWxkCiAgICBiID0gYnVpbGQuQnVpbGRlcigpCmV4Y2VwdCBlOgogICAgcHJpbnQoZSkKICAgIGIgPSB0eXBlKCIiLCAoKSwge30pKCkKCmIuZmxhZyA9IG9zLmVudmlyb25bIkZMQUciXQpiLmZsYWdfZm9ybWF0ID0gb3MuZW52aXJvblsiRkxBR19GT1JNQVQiXQoKaWYgaGFzYXR0cihiLCAicHJlYnVpbGQiKToKICAgIGIucHJlYnVpbGQoKQoKY2ZsYWdzID0gWyItREZMQUc9JXMiICUgYi5mbGFnLCAiLURGTEFHX0ZPUk1BVD0lcyIgJSBiLmZsYWdfZm9ybWF0XQppZiBoYXNhdHRyKGIsICJ4ODZfNjQiKSBhbmQgbm90IGIueDg2XzY0OgogICAgY2ZsYWdzLmFwcGVuZCgiLW0zMiIpCgppZiBoYXNhdHRyKGIsICJleGVjdXRhYmxlX3N0YWNrIikgYW5kIGIuZXhlY3V0YWJsZV9zdGFjazoKICAgIGNmbGFncy5hcHBlbmQoIi16ZXhlY3N0YWNrIikKCmlmIGhhc2F0dHIoYiwgInN0YWNrX2d1YXJkcyIpIGFuZCBub3QgYi5zdGFja19ndWFyZHM6CiAgICBjZmxhZ3MuYXBwZW5kKCItZm5vLXN0YWNrLXByb3RlY3RvciIpCiAgICBjZmxhZ3MuYXBwZW5kKCItRF9GT1JUSUZZX1NPVVJDRT0wIikKZWxzZToKICAgIGNmbGFncy5hcHBlbmQoIi1EX0ZPUlRJRllfU09VUkNFPTIiKQogICAgY2ZsYWdzLmFwcGVuZCgiLWZzdGFjay1jbGFzaC1wcm90ZWN0aW9uIikKICAgIGNmbGFncy5hcHBlbmQoIi1mc3RhY2stcHJvdGVjdG9yLXN0cm9uZyIpCgppZiBoYXNhdHRyKGIsICJzdHJpcCIpIGFuZCBiLnN0cmlwOgogICAgY2ZsYWdzLmFwcGVuZCgiLXMiKQoKaWYgaGFzYXR0cihiLCAiZGVidWciKSBhbmQgYi5kZWJ1ZzoKICAgIGNmbGFncy5hcHBlbmQoIi1nIikKCmlmIGhhc2F0dHIoYiwgInBpZSIpIGFuZCBiLnBpZToKICAgIGNmbGFncy5hcHBlbmQoIi1mUElFIikKICAgIGNmbGFncy5hcHBlbmQoIi1waWUiKQogICAgY2ZsYWdzLmFwcGVuZCgiLVdsLC1waWUiKQplbHNlOgogICAgY2ZsYWdzLmFwcGVuZCgiLW5vLXBpZSIpCgpjZmxhZ3MgPSAiICIuam9pbihjZmxhZ3MpCmlmIGhhc2F0dHIoYiwgImV4dHJhX2ZsYWdzIik6CiAgICBjZmxhZ3MgPSBjZmxhZ3MgKyAiICIgKyAiICIuam9pbihiLmV4dHJhX2ZsYWdzKQoKb3MuZW52aXJvblsiQVNGTEFHUyJdID0gY2ZsYWdzCm9zLmVudmlyb25bIkNGTEFHUyJdID0gY2ZsYWdzCm9zLmVudmlyb25bIkNYWEZMQUdTIl0gPSBjZmxhZ3MKCmlmIG5vdCBoYXNhdHRyKGIsICJkb250X3RlbXBsYXRlIik6CiAgICBiLmRvbnRfdGVtcGxhdGUgPSBbXQpiLmRvbnRfdGVtcGxhdGUuYXBwZW5kKCJwcm9ibGVtLm1kIikKYi5kb250X3RlbXBsYXRlLmFwcGVuZCgicHJvYmxlbS5qc29uIikKYi5kb250X3RlbXBsYXRlLmFwcGVuZCgiYnVpbGQucHkiKQoKZm9yIGN1cnJfZGlyLCBzdWJfZGlycywgZmlsZXMgaW4gb3Mud2FsaygiLiIpOgogICAgaWYgY3Vycl9kaXIgaW4gYi5kb250X3RlbXBsYXRlOgogICAgICAgIGNvbnRpbnVlCiAgICBmb3IgZm5hbWUgaW4gZmlsZXM6CiAgICAgICAgZnBhdGggPSBvcy5wYXRoLmpvaW4oY3Vycl9kaXIsIGZuYW1lKQogICAgICAgIGlmIGZwYXRoWzI6XSBpbiBiLmRvbnRfdGVtcGxhdGU6CiAgICAgICAgICAgIGNvbnRpbnVlCiAgICAgICAgcHJpbnQoZnBhdGhbMjpdKQoKICAgICAgICB0cnk6CiAgICAgICAgICAgIHdpdGggb3BlbihmcGF0aCkgYXMgZjoKICAgICAgICAgICAgICAgIGNvbnRlbnRzID0gZi5yZWFkKCkKICAgICAgICBleGNlcHQ6CiAgICAgICAgICAgIGNvbnRpbnVlCgogICAgICAgIHRlbXBsYXRlID0gamluamEyLlRlbXBsYXRlKGNvbnRlbnRzKQoKICAgICAgICB3aXRoIG9wZW4oZnBhdGgsICJ3IikgYXMgZjoKICAgICAgICAgICAgZi53cml0ZSh0ZW1wbGF0ZS5yZW5kZXIoYi5fX2RpY3RfXykpCgppZiBoYXNhdHRyKGIsICJidWlsZCIpOgogICAgYi5idWlsZCgpCmVsc2U6CiAgICBpZiBoYXNhdHRyKGIsICJwcm9ncmFtX25hbWUiKToKICAgICAgICBvcy5zeXN0ZW0oIm1ha2UgJXMiICUgYi5wcm9ncmFtX25hbWUpCiAgICBlbHNlOgogICAgICAgIG9zLnN5c3RlbSgibWFrZSIpCgppZiBub3QgaGFzYXR0cihiLCAicHJvZ3JhbV9uYW1lIik6CiAgICBiLnByb2dyYW1fbmFtZSA9ICJtYWluIgoKaWYgbm90IGhhc2F0dHIoYiwgImV4ZWMiKToKICAgIGIuZXhlYyA9ICIuLyIgKyBiLnByb2dyYW1fbmFtZQppZiBoYXNhdHRyKGIsICJhc2xyIikgYW5kIG5vdCBiLmFzbHI6CiAgICBiLmV4ZWMgPSAic2V0YXJjaCAtUiAiICsgYi5leGVjCgp3aXRoIG9wZW4oInN0YXJ0LnNoIiwgInciKSBhcyBmOgogICAgZi53cml0ZSgiIyEvYmluL2Jhc2hcbiVzXG4iICUgYi5leGVjKQpvcy5jaG1vZCgic3RhcnQuc2giLCBzdGF0LlNfSVJXWFUgfCBzdGF0LlNfSVhHUlAgfCBzdGF0LlNfSVhPVEgpCgppZiBoYXNhdHRyKGIsICJhcnRpZmFjdHMiKToKICAgIG9zLnN5c3RlbSgidGFyIGN6dmYgYXJ0aWZhY3RzLnRhci5neiAiICsgIiAiLmpvaW4oYi5hcnRpZmFjdHMpKQoKaWYgaGFzYXR0cihiLCAicG9zdGJ1aWxkIik6CiAgICBiLnBvc3RidWlsZCgpCgppZiBub3QgaGFzYXR0cihiLCAibG9va3VwcyIpOgogICAgYi5sb29rdXBzID0geyJmbGFnIjogYi5mbGFnfQplbGlmICJmbGFnIiBub3QgaW4gYi5sb29rdXBzOgogICAgYi5sb29rdXBzWyJmbGFnIl0gPSBiLmZsYWcKCndpdGggb3BlbigibWV0YWRhdGEuanNvbiIsICJ3IikgYXMgZjoKICAgIGYud3JpdGUoanNvbi5kdW1wcyhiLmxvb2t1cHMpKQoKaWYgaGFzYXR0cihiLCAicmVtb3ZlIik6CiAgICBmb3IgZiBpbiBiLnJlbW92ZToKICAgICAgICBvcy5yZW1vdmUoZikK' | base64 -d | python3
RUN mv metadata.json /challenge
RUN if [ -f artifacts.tar.gz ]; then mv artifacts.tar.gz /challenge; fi

RUN chmod +x start.sh
RUN chown -R app:app /app

USER app:app
CMD ./start.sh

EXPOSE 5000
# PUBLISH 5000 AS service
