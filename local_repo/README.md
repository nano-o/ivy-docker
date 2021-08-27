Steps to get running:
- make sure that the ivy submodule is up to date (and its own submodules too)
- `docker-compose build ivy`
- Run the container: `docker-compose run ivy`
- Inside the container, build and setup with `source /home/user/setup.sh`

Now you can work on Ivy on the host and have your changes reflected in the container.
