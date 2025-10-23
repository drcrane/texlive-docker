FROM alpine:3.22

RUN apk add --no-cache texlive-xetex texmf-dist-latexrecommended

RUN adduser -D -g users -u 1001 user && \
	mkdir -p /home/user && \
	chown -R user:users /home/user

USER user
RUN mkdir /home/user/bin
COPY compileall.sh /home/user/bin
ENV HOME /home/user
ENV PATH "/home/user/bin:${PATH}"
WORKDIR /home/user
CMD ["/bin/ash"]

