# Docker template

Template project for Pollen Robotics docker images. It provides pre-configured tools and guidelines for making your own image.

## Git Workflow

The git workflow is based on [gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) with main, develop, and features branches. It is already used in our [python template](https://github.com/pollen-robotics/python-template) if you need to read more.

Feel free to use the workflow that suits your project, but these branches are used by the CI/CD to automatically build and tag your images.

## CI/CD

The docker image is automatically built with PR, and automatically pushed to dockerhub with a commit to develop (tag:develop) or main (tag:latest). So if the PR is accepted it is pushed. It is also pushed when a tag is added (i.e. *v1.0*. note that **v** is mandatory ), most likely for releases.

To enable the github action to work you need to modify [.github/workflows/build_push.yml](.github/workflows/build_push.yml) to set the `IMAGE_NAME` you like.

Then you need to create a [token](https://hub.docker.com/settings/security) to be able to pull the base image, and push yours. Add this token to your [
github secrets](https://github.com/pollen-robotics/docker_template/settings/secrets/actions).

## Make your docker image

Most likely you need to use [ROS Pollen Base](https://github.com/pollen-robotics/docker_ros_pollen_base) as your base image. This is what the minimal docker file does. Extend this file to make your own image.

CI/CD building is only triggered for PR and may be quite long to generate images. You may want to build the image locally when you work in your branch.

```console
./pull_sources.sh [--shallow]
export DOCKER_BUILDKIT=1
docker build -t pollenrobotics/template:branch-name .
```

Some tips are listed below and illustrated in the Dockerfile.

### SSH keys

When cloning private repos you need to configure ssh keys. You need to generate a new pair for each private repo. No passphrase needed. This procedure is [documented here](https://github.com/marketplace/actions/webfactory-ssh-agent#support-for-github-deploy-keys)

``` ssh-keygen -t ed25519 -C "git@github.com:pollen-robotics/ReachyV2_vision.git" ```

Then copy the public key to the deploy keys of the repo ([example](https://github.com/pollen-robotics/ReachyV2_vision/settings/keys))

Copy the private to the repo of the Docker image ([example](https://github.com/pollen-robotics/docker_template/settings/secrets/actions))

[Docker_webrtc](https://github.com/pollen-robotics/docker_webrtc) uses multiple keys if you need another example.


## Examples

Many examples are available on our [Docker central](https://github.com/pollen-robotics/docker_central)