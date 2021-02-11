
oc get pod --field-selector=status.phase==Succeeded
oc delete pod --field-selector=status.phase==Succeeded
oc get all --selector app=nfz-$1 -o name
oc delete all --selector app=nfz-$1

# oc delete route nfz-$1
# oc delete deployments nfz-$1
# oc delete service nfz-$1
# oc delete pipeline build-spring-boot-code-from-git
# oc delete cm maven
# oc delete pvc shared-workspace-pvc

# oc apply -f ./pvc.yaml
# oc create -f ./build-spring-boot-code-from-git.yaml
# oc create cm maven --from-file=./settings.xml

tkn pipeline start build-spring-boot-code-from-git \
    -w name=shared-workspace,claimName=shared-workspace-pvc\
    -w name=maven-settings,config=maven \
    -p deployment-name=nfz \
    -p git-revision=$1 \
    -p git-url=https://github.com/mmartofel/nfz.git \
    -p IMAGE=image-registry.openshift-image-registry.svc:5000/nfz/nfz-spring-boot
