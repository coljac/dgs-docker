# Dragon Go Server docker image

The source for the [Dragon Go Server](http://dragongoserver.net) is readily [available](https://sourceforge.net/p/dragongoserver/dgs-main/ci/master/tree/) for you to run your own copy for development or other purposes. This docker image sets up Apache/Mysql/PHP and deploys a fresh copy.

Best invoked to run on port 80 on localhost due to redirect issues.

Run as follows (see `run.sh`):

`docker run --name dgs -p 80:80 coljac/dragongo-dev:latest`

Then brows to `http://localhost/index.php`.
