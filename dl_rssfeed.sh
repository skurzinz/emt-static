# bin/bash

RSS_XML=./data/rss.xml

rm ${RSS_XML}

curl https://kaiserin.hypotheses.org/feed >> ${RSS_XML}