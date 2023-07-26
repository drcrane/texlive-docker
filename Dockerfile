FROM alpine:3.17

RUN adduser -D -g users user && \
	mkdir -p /home/user && \
	chown -R user:users /home/user

RUN apk add --no-cache texlive-xetex

USER user
RUN mkdir /home/user/bin
COPY compileall.sh /home/user/bin
ENV HOME /home/user
ENV PATH "/home/user/bin:${PATH}"
WORKDIR /home/user
CMD ["/bin/ash"]

