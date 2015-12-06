FROM ruby:2.2
ENV HOME /root
WORKDIR $HOME

RUN apt-get update && apt-get install git
RUN git clone https://github.com/thoughtbot/hound.git
WORKDIR $HOME/hound
RUN echo 'gem "therubyracer"' >> Gemfile && echo 'gem "foreman"' >> Gemfile
RUN gem install bundler
RUN bundle install --without test development

ENV RAILS_ENV production
ADD .env $HOME/hound/

CMD bundle exec rake db:create && bundle exec rake db:migrate && bundle exec rake assets:precompile && bundle exec foreman start

