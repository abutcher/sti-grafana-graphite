# sti-grafana-graphite

This is a grafana image with a graphite data source that is meant to
be used with
[source-to-image](https://github.com/openshift/source-to-image). The
image combines with a repository containing any number of dashboards
in json format and preloads them into grafana. The graphite data
source is configured by running the resultant image with a
`GRAPHITE_URL` environment variable.

## Source to Image

The first thing you need to do is build the grafana-graphite imagge.

```
make build
```

Next, combine that image with your source.

```
sti build https://github.com/abutcher/dash-test.git grafana-graphite dash-test
```

## Running

```
docker run -p 3000:3000 \
           -e GRAPHITE_URL=https://my-graphite-web.example.com/ \
	   -d dash-test
```

## Testing

To test the whole process run `make test`. This will build the
grafana-graphite image and combine it with a local source. `sti` will
need to be in your `PATH` for this to function.

## TODO

* Allow user credentials to be set via environment variables or so.
* Make use of `save-artifacts` so that configs can live on.
* Other cool stuff.
