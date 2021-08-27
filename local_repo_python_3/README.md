Steps to get running:
- `docker-compose build ivy`
- Run the container: `docker-compose run ivy`
- Inside the container, install Ivy with `source /home/user/setup.sh`

Now you can work on Ivy (in `./ivy`) on the host and have your changes reflected in the container.

