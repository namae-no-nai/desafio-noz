FROM ruby:3.0.3
RUN apt-get update -y && apt-get install -y nodejs postgresql-client libpq-dev
WORKDIR /desafio-noz
COPY Gemfile /desafio-noz/Gemfile
COPY Gemfile.lock /desafio-noz/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /desafio-noz

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]