docker-php
================

Base docker image to run PHP applications on Apache


Building the base image
-----------------------

To create the base image `drasamsetti/web-app`, execute the following command on the apache-php folder:

    docker build -t drasamsetti/web-app .


Running your Apache+PHP docker image
------------------------------------

Start your image binding the external ports 80 in all interfaces to your container:

    docker run -d -p 80:80 drasamsetti/web-app


Enable .htaccess files
------------------------------------

If you app uses .htaccess files you need to pass the ALLOW_OVERRIDE environment variable

    docker run -d -p 80:80 -e ALLOW_OVERRIDE=true drasamsetti/web-app


Loading your custom PHP application
-----------------------------------

This image can be used as a base image for your PHP application. Create a new `Dockerfile` in your
PHP application folder with the following contents:

    FROM drasamsetti/web-app

After that, build the new `Dockerfile`:

    docker build -t username/my-php-app .

And test it:

    docker run -d -p 80:80 username/my-php-app


Loading your custom PHP application with composer requirements
--------------------------------------------------------------

Create a Dockerfile like the following:

    FROM drasamsetti/web-app
    RUN apt-get update && apt-get install -yq git && rm -rf /var/lib/apt/lists/*
    RUN rm -fr /app
    ADD . /app
    RUN composer install

- Replacing `git` with any dependencies that your composer packages might need.
- Add your php application to `/app`

