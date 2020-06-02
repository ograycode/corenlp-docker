FROM openjdk:8-jre-alpine

LABEL maintainer="Qi Yang <i@yangqi.me>"

RUN apk add --update --no-cache \
	 unzip \
	 wget && \
	wget -q http://nlp.stanford.edu/software/stanford-corenlp-4.0.0.zip && \
	unzip stanford-corenlp-4.0.0.zip -d /stanford-corenlp && \
	rm stanford-corenlp-4.0.0.zip && \
	wget -q -P /stanford-corenlp http://nlp.stanford.edu/software/stanford-corenlp-4.0.0-models-english.jar

WORKDIR /stanford-corenlp

RUN export CLASSPATH="`find . -name '*.jar'`"

ENV PORT 9000

EXPOSE $PORT

CMD java -mx8g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port ${PORT}
