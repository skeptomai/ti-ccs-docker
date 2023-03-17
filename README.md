# cd ti-ccs-docker repo

# build the image
The default UID:GID is 1000:1000.
To build with adding the desired user, use:
```
docker build --build-arg USER_ID=$(id -u <username>) --build-arg GROUP_ID=$(id -g <username>) -t ti-ccs .
```

# cd project dir

# import project to workspace
# clean and build the workspace
If you didn't set USER_ID and GROUP_ID, run the command without `-u $(id -u):$(id -g)`
```
docker run -u $(id -u):$(id -g) --rm -v ${PWD}:/workdir/project ti-ccs /bin/bash -c '\
    eclipse -noSplash -data /workdir/ccs_workspace -application com.ti.ccstudio.apps.projectImport -ccs.location /workdir/project && \
	eclipse -noSplash -data /workdir/ccs_workspace -application com.ti.ccstudio.apps.projectBuild -ccs.workspace -ccs.clean && \
    eclipse -noSplash -data /workdir/ccs_workspace -application com.ti.ccstudio.apps.projectBuild -ccs.workspace'
```
