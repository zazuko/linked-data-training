# Zazuko Linked Data Training

* Github repository for this course [zazuko/linked-data-training](https://github.com/zazuko/linked-data-training)

## Presentations

* [Linked Data basics](LD-Basics/index.html)
* [SPARQL](SPARQL/index.html)
* [Ontologies](Ontologies/index.html)

## References

* [References]()

## Exercises

* [Exercises](https://github.com/zazuko/linked-data-training/blob/master/exercises/exercises.md)

## Sample Data & Queries

### Based on exercise questions

* [The Big Bang Theory Dataset](https://github.com/zazuko/tbbt-ld/tree/master/data/person) - schema.org based dataset with `schema:knows` relations based on characters of _The Big Bang Theory_ TV series.
* Federal Statistical Office & Swisstopo
    * [Get a specific shape in Swisstopo](https://goo.gl/sLKw6R)
    * [Get specific municipalities at FSO](https://goo.gl/CMDv6U)
    * Federated query combining the two
* [Gujer Fotos Stadtarchiv Uster](https://github.com/zazuko/stadtarchiv-uster) -  A simple georeferenced RDF dataset containing historic pictures from Swiss photographer [Julius Gujer](https://data.stadt-zuerich.ch/dataset/bauhistorische-fotosammlung-von-uster-1893-1909-von-julius-gujer)
* Language filtering based on sample data in [DIDOK list](https://github.com/zazuko/ld-didok/blob/master/input/static.ttl). Try it on the [SPARQL endpoint](http://lod.opentransportdata.swiss/sparql/).
    * Graph: https://linked.opendata.swiss/graph/FOT/didok>
    * [Tram](http://lod.opentransportdata.swiss/stationtype/Tram)
    * [Funicular](http://lod.opentransportdata.swiss/stationtype/Funicular)
* Wikidata: [Get airport codes, labels & location](https://t.co/gyWQ7MRzL6)
* GeoSPARQL
    * [Entrypoint graph & observations](https://goo.gl/d79MGy)
    * [Example temperature prediction](https://goo.gl/SmXjoJ) 
    * [GeoSPARQL spec](http://www.opengeospatial.org/standards/geosparql)
    * Documentation in [Stardog Triplestore](https://www.stardog.com/docs/#_geospatial_query)

### Other examples

* [Federal Statistical Office](https://github.com/zazuko/fso-lod/blob/master/doc/eCH0071/sparql.md) - More sample SPARQL queries on the Swiss Historicised Municipality register. Includes federated queries on the Swisstopo/ld.geo.admin.ch dataset
* Translations of Swiss municipality names from Wikidata by [Pasquale Di Donato](https://twitter.com/p1d1d1/status/864495483905093633)
    - [Table view](https://t.co/HOH8ajhxNd)
    - [Map view](https://t.co/5vZHvwswZ5)
* Public transport stops in Switzerland [above 3000m](https://t.co/MH5aOsKkaI), based on [Swisstopo tweet](https://twitter.com/swiss_geoportal/status/964083114174832640)