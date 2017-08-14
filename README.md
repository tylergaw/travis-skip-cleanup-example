## Travis CI: Demonstration of a change between Precise and Trusty

An isolated example of a change in functionality between Travis Precise and Trusty.

### The changed appears to be skip_cleanup

Precise builds seem to function as if `skip_cleanup` is set to `true` by default. Because the node dependencies are still available in the `deploy` section. Trusty acts as if `skip_cleanup` is set to `false` by default because the node dependencies are not available in `deploy`.

### Details

The `.travis.yml` conf in this project is a slimmed down version of a common conf I've used on a dozen or so projects over the last few years. Quick rundown. These projects use npm to install dependencies, test, and build. On tags the `deploy` cycle is triggered and another script runs. Usually a shell script. (`deploy.sh`) in this project.

### What happens on Precise

On Precise, creating a new tag runs as expected. `npm install` installs the dependencies. In this example just the `moment` package. The `script` section runs `npm test` which uses node to execute a trivial example script that uses the node dependency.

Once `npm test` completes, the conf sees there is a new tag and goes to `deploy` which executes `deploy.sh`.

Each project's deploy script is responsible for usually setting a NODE_ENV var to production and then building the project for deployment.

deploy.sh
```
export NODE_ENV=production
npm run build # This works in Precise, but fails in Trusty.
# Deploy the artifacts from npm run build above. (usually to S3)
```

`npm run build` calls the trivial `build.js` which also attempts to use the `moment` package.

On Precise this works as expected. `moment` is available.

### What happens on Trusty

On Trusty everything works until the `deploy` stage. When our `deploy.sh` calls `npm run build` we see an error that `moment` is not found.
