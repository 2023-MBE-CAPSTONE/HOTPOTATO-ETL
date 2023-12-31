FROM --platform=linux/amd64 python:3.11

WORKDIR /src

RUN pip install pipenv
COPY ./Pipfile ./Pipfile
COPY ./Pipfile.lock ./Pipfile.lock
COPY ./video_comment_scrapper.py ./video_comment_scrapper.py
RUN pipenv install --dev --system --deploy

RUN wget -N https://chromedriver.storage.googleapis.com/72.0.3626.69/chromedriver_linux64.zip -P ~/
RUN unzip ~/chromedriver_linux64.zip -d ~/
RUN rm ~/chromedriver_linux64.zip
RUN mv -f ~/chromedriver /usr/local/bin/chromedriver
RUN chown root:root /usr/local/bin/chromedriver
RUN chmod 0755 /usr/local/bin/chromedriver

RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
RUN apt-get -y update
RUN apt-get -y install google-chrome-stable

CMD ["python","./video_comment_scrapper.py"]