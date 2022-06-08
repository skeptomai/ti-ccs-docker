# cd ti-ccs-docker repo

# build the image
docker build -t ti-ccs .

# cd project dir

# import project to workspace
# clean and build the workspace
docker run --rm -v ${PWD}:/workdir/project ti-ccs /bin/bash -c '\
    eclipse -noSplash -data /workdir/ccs_workspace -application com.ti.ccstudio.apps.projectImport -ccs.location /workdir/project && \
	eclipse -noSplash -data /workdir/ccs_workspace -application com.ti.ccstudio.apps.projectBuild -ccs.workspace -ccs.clean && \
    eclipse -noSplash -data /workdir/ccs_workspace -application com.ti.ccstudio.apps.projectBuild -ccs.workspace'


# start as daemon / detached
docker run -d ti-ccs bash
docker ps
docker exec -it <container id> bash
