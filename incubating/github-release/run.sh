# !/bin/bash

# check if the required vars are set
for reqVar in GITHUB_TOKEN CF_REPO_OWNER CF_REPO_NAME; do
    if [ -z ${!reqVar} ]; then echo "The variable $reqVar is not set, stopping..."; exit 1; fi
done

if [ "$PRERELEASE" = "true" ]; then PRERELEASE="-p"; else PRERELEASE=""; fi
if [ "$FILES" = '${{FILES}}' ]; then FILES=""; fi
if [ "$CF_TARGET_BRANCH" ]; then CF_TARGET_BRANCH="--target $CF_TARGET_BRANCH"; fi

github-release release --user $CF_REPO_OWNER --repo $CF_REPO_NAME --tag $RELEASE_TAG --name $RELEASE_NAME --description $RELEASE_DESCRIPTION

if [ ! -z "$FILES" ]; then
 for file in $FILES; do
     echo "Uploading file $file........"
     github-release upload --user $CF_REPO_OWNER --repo $CF_REPO_NAME --tag $CF_BRANCH_TAG_NORMALIZED --name $(basename $file) --file $file
 done
fi
