# OneChart Service

This is a Keptn Service that provides a default Helm Chart template that can be used to deploy a service.

The default Helm chart is [OneChart](https://gimlet.io/onechart/getting-started/) from the Gimlet project.

## Compatibility Matrix

| Keptn Version    | [OneChart-Service Docker Image](https://hub.docker.com/r/keptnsandbox/onechart-service/tags) |
|:----------------:|:----------------------------------------:|
|       0.8.x      | keptnsandbox/onechart-service:0.1.0 |

## Installation

### Deploy in your Kubernetes cluster

To deploy the current version of the *onechart-service* in your Keptn Kubernetes cluster, apply the [`deploy/service.yaml`](deploy/service.yaml) file:

```console
kubectl apply -f deploy/service.yaml
```

This should install the `onechart-service` together with a Keptn `distributor` into the `keptn` namespace, which you can verify using

```console
kubectl -n keptn get deployment onechart-service
kubectl -n keptn get pods -l run=onechart-service
```

### Uninstall

To delete a deployed *onechart-service*, use the file `deploy/*.yaml` files from this repository and delete the Kubernetes resources:

```console
kubectl delete -f deploy/service.yaml
```

## Development

Development can be conducted using any GoLang compatible IDE/editor (e.g., Jetbrains GoLand, VSCode with Go plugins).

It is recommended to make use of branches as follows:

* `master` contains the latest potentially unstable version
* `release-*` contains a stable version of the service (e.g., `release-0.1.0` contains version 0.1.0)
* create a new branch for any changes that you are working on, e.g., `feature/my-cool-stuff` or `bug/overflow`
* once ready, create a pull request from that branch back to the `master` branch

When writing code, it is recommended to follow the coding style suggested by the [Golang community](https://github.com/golang/go/wiki/CodeReviewComments).

### Where to start

- This service handles `sh.keptn.event.service.create.started` events. 
- This service creates a Helm chart based on OneChart. The input that is coming in is the name of the project. 
  Other details such as the image name are not yet available at this point. You can find the spec of the cloud event that is coming in here.
- The event handle code is in https://github.com/keptn-sandbox/onechart-service/blob/master/eventhandlers.go#L27

### Common tasks



* Build the docker image: `make docker-build`
* Run the docker image locally: `make docker-run`
* Push the docker image to DockerHub: `make docker-push`
* Deploy the service: `make deploy`
* Do a full dev iteration with: `make iterate`
* Watch the deployment using `kubectl`: `kubectl -n keptn get deployment keptn-service-template-go -o wide`
* Get logs using `kubectl`: `kubectl -n keptn logs deployment/onechart-service -f`

## Automation

### GitHub Actions: Automated Pull Request Review

This repo uses [reviewdog](https://github.com/reviewdog/reviewdog) for automated reviews of Pull Requests. 

You can find the details in [.github/workflows/reviewdog.yml](.github/workflows/reviewdog.yml).

### GitHub Actions: Unit Tests

This repo has automated unit tests for pull requests. 

You can find the details in [.github/workflows/tests.yml](.github/workflows/tests.yml).

### GH Actions/Workflow: Build Docker Images

This repo uses GH Actions and Workflows to test the code and automatically build docker images.

Docker Images are automatically pushed based on the configuration done in [.ci_env](.ci_env) and the two [GitHub Secrets](https://github.com/keptn-sandbox/keptn-service-template-go/settings/secrets/actions)
* `REGISTRY_USER` - your DockerHub username
* `REGISTRY_PASSWORD` - a DockerHub [access token](https://hub.docker.com/settings/security) (alternatively, your DockerHub password)

## How to release a new version of this service

It is assumed that the current development takes place in the master branch (either via Pull Requests or directly).

To make use of the built-in automation using GH Actions for releasing a new version of this service, you should

* branch away from master to a branch called `release-x.y.z` (where `x.y.z` is your version),
* write release notes in the [releasenotes/](releasenotes/) folder,
* check the output of GH Actions builds for the release branch, 
* verify that your image was built and pushed to DockerHub with the right tags,
* update the image tags in [deploy/service.yaml], and
* test your service against a working Keptn installation.

If any problems occur, fix them in the release branch and test them again.

Once you have confirmed that everything works and your version is ready to go, you should

* create a new release on the release branch using the [GitHub releases page](https://github.com/keptn-sandbox/keptn-service-template-go/releases), and
* merge any changes from the release branch back to the master branch.

## License

Please find more information in the [LICENSE](LICENSE) file.
