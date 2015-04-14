FROM fedora:20

RUN yum -y install git libxml2-devel libxslt libxslt-devel sudo memcached gcc-c++ ruby-devel make postgresql-devel

RUN useradd -m miqbuilder
RUN echo "miqbuilder:miqbuilder" | chpasswd

RUN echo 'miqbuilder ALL=(ALL) ALL' >> /etc/sudoers.d/miqbuilder

#RUN service memcached start
#RUN chkconfig memcached on

USER miqbuilder

RUN gem install bundler -v "~>1.3"

RUN git clone https://github.com/ManageIQ/manageiq /home/miqbuilder/manageiq
WORKDIR /home/miqbuilder/manageiq/vmdb

RUN /bin/bash -l -c "bundle install --without qpid"

RUN cd ..  && vmdb/bin/rake build:shared_objects

RUN /bin/bash -l -c "bundle install --without qpid"

RUN cp config/database.pg.yml config/database.yml

EXPOSE 3000

ENV PORT=3000

ENTRYPOINT bin/rake
