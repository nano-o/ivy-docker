Steps to get running:
- `docker-compose build ivy`
- Clone ivy in `./ivy`: `git clone --recurse-submodules https://github.com/kenmcmil/ivy.git`
- Run the container: `docker-compose run ivy`
- Inside the container, build and setup with `source /home/user/setup.sh`

Now you can work on Ivy on the host and have your changes reflected in the container.
