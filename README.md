# Manageiq Dockerized

This is a WIP repo for dockerizing [Manageiq](https://github.com/ManageIQ/manageiq).

The current Dockerfile is based on [instructions from manageiq.org](http://manageiq.org/community/install-from-source/)

Open issues/ things that need to be added:
<br>
1. creating an additional container for postgres <br>
2. running memcached - in same container with manageiq or separate? <br>
3. running multiple processes in manageiq container (UI, workers, etc.) - requires the container to be priviledged
and run with systemd. <br>
4. changing the config/database.pg.yml / config/database.yml to get db host,port injected based on the db container
by env variables via docker. <br>
5. how/when to run the migrations ('rake db:migrate') - it can be done via an external container that runs once,
or added as part of 'rake evm:start' <br>
6. when/where run schema creations and role additions (createdb, create role, etc. as mentioned in 
[7.e](http://manageiq.org/community/install-from-source/))

Note - if this is also to be put as part of k8s, the required design would probably be:
manageiq container in a pod, postgres in another pod, and a service that connects to postgres pod (through which manageiq
can communicate with postgres).
