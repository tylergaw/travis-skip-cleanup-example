## Travis CI: Demonstration of a change between Precise and Trusty

An isolated example of a change in functionality between Travis Precise and Trusty.

The `.travis.yml` conf in this project is a slimmed down version of a common conf I've used on a dozen or so projects over the last few years. Quick rundown. These projects use npm to install dependencies, test, and build. On tags the `deploy` cycle is triggered and another script is triggered. Usually a shell script. (`deploy.sh`) in this project.

Each project's deploy script is responsible for usually setting a NODE_ENV to production and then building the project for deployment.

deploy.sh
```
export NODE_ENV=production
npm run build # This works in Precise, but fails in Trusty.
# Deploy the artifacts from npm run build above. (usually to S3)
```



### skip_cleanup

Precise builds seem to function as if `skip_cleanup` is set to `true` by default. Because the node dependencies are still available in the `deploy` section. Trusty acts as if `skip_cleanup` is set to `false` by default because the node dependencies are not available in `deploy`.
