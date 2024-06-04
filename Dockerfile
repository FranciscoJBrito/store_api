FROM ruby:3.0.6-bullseye 

# set folder
WORKDIR /home/developer/app

# copy files
COPY Gemfile Gemfile.lock ./

# install gems
RUN gem install bundler:2.4.22 && bundle install

# copy the main app
COPY . .

# expose port
EXPOSE 3000

# run server
ENTRYPOINT [ "./entrypoints/docker-entrypoints.sh" ]