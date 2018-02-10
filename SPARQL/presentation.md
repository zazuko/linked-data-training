class: center, middle

# Mastering SPARQL

> Or: How I Learned to Stop Worrying and Love Linked Data

[Zazuko GmbH](http://www.zazuko.com/)

This work is licensed under a

[Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by/4.0/)

![CC-BY-4.0 Logo](../img/cc-by-88x31.png)

---

# Some links for a start

* RDF & Linked Data history & basics: [Linked Data on Speed](http://presentations.zazuko.com/LD-Speed/)
    - [Video @ UniBE](https://cast.switch.ch/vod/clips/btt0uue1l/streaming.html) (Flash only)
    - [Via AAI-Login](https://tube.switch.ch/videos/24dc6403) (HTML5)
* At home: [SPARQL in 11 minutes](https://www.youtube.com/watch?v=FvGndkpa4K0)
* [SPARQL Tutorial](https://jena.apache.org/tutorials/sparql.html)
* Book: Learning SPARQL, [Homepage](http://www.learningsparql.com/), [Safari Books Online](http://proquest.safaribooksonline.com/book/web-development/rdf/9781449371449)
* Book: Semantic Web for the Working Ontologist [Homepage](http://workingontologist.org/), [Safari Books Online](http://proquest.safaribooksonline.com/book/web-design-and-development/9780123859655)

---

# References: Standards

* [RDF 1.1 Primer](http://www.w3.org/TR/rdf11-primer/)
* [Turtle Serialization](http://www.w3.org/TR/turtle/)
* [JSON for Linking Data](http://json-ld.org/) (JSON-LD)
* [SPARQL 1.1 Query Language](http://www.w3.org/TR/sparql11-query/)

---

# Data model

![A Thing](img/AThing.svg)

---

# RDF data model

![A Thing with URIs](img/AThing2.svg)

---

# RDF data model

* Instead of a document I describe a single information
* Think of everything between `<...>` as URIs, preferably resolvable HTTP URIs

Example (Pseudo-[N-Triples](https://en.wikipedia.org/wiki/N-Triples), one statement per line):

```turtle
<ktk> <givenName> "Adrian" . 
<ktk> <familyName> "Gschwend" .
<ktk> <knows> <someoneElse> .
```

---

# RDF data model (2)

If you follow `<someoneElse>` you might find:

```turtle
<someoneElse> <givenName> "John" .
<someoneElse> <familyName> "Doe" .
<someoneElse> <knows> <againSomeoneElse> .
<someoneElse> <knows> <evenMore> .
```

And that is the whole point of Linked Data!

---

# SPARQL

* It’s a real standard & vendors respect it (yeah!)
* W3C standard
* Query language for Linked Data
* Scales (in memory)
* Supports Federated Queries
* Commercial vendors, growing marked
* Open Source implementations

---

# SPARQL Basics

* `?` or `$` for variables
* `SELECT` for selection, `WHERE` for conditions
* `WHERE` typically combines multiple conditions, over multiple subjects
* In SQL this would be a `JOIN`
* Without the headache you get by using `JOIN`

---

# SPARQL Pattern Matching

* Remember: Everything is described in subject-predicate-object combinations
* We simply define what we want
* And assign variables to those parts SPARQL should fill in
* That's all!
* Starting point today: [Stadtarchiv Uster](https://github.com/zazuko/stadtarchiv-uster/blob/master/doc/SPARQL.md)

---

# The "Return everything" statement

* Always use `LIMIT`, many stores return a lot or everything by default!

```sparql
SELECT * WHERE {
  ?subject ?predicate ?object .
} LIMIT 10
```

Feel free to use `?s ?p ?o` instead ;)

---

# Matching for classes

* RDF defines `<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>`
    - (often `rdf:type`)
    - think of it like classes
* Typically (not always) classes start with uppercase letter
* Predicates with lowercase letters
* There is a shortcut for `rdf:type` in Turtle & SPARQL syntax: `a`

```sparql
SELECT * WHERE {
  ?subject <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <https://schema.org/Person> .
} LIMIT 10
```

Would return all `?subject`s in the store that are of type `<https://schema.org/Person>`

---

# Prefixes

* URIs can be long
* Makes queries hard to read
* XML introduced prefixes for that
* RDF provides this as well, for example in Turtle-syntax or SPARQL
* Unfortunately Turtle & SPARQL differ a bit, SPARQL definition of a prefix:

```sparql
PREFIX dct: <http://purl.org/dc/terms/> 
```

* After that you can use `dct:creator` instead of its full URI `http://purl.org/dc/terms/creator`
* There is no fix prefix mapping, you might find different prefixes for same URI
* Use services like [prefix.cc](http://prefix.cc/) to get an idea 

---

# Prefixes (2)

Previous examples with prefixes:

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX schema: <http://schema.org/>

SELECT * WHERE {
  ?subject rdf:type schema:Person .
} LIMIT 10
```

Remember the shortcut `a`, always works with or without prefix!

---

# When we talk about the same subject

* We often want to have predicate-object combinations from the same subject
* This can be shortened as well by using `;` instead of `.` on the line, example:

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX schema: <http://schema.org/>

SELECT * WHERE {
  ?subject rdf:type schema:Person ;
    schema:givenName ?givenName ;
    schema:familyName ?familyName .
} LIMIT 10
```

This feels a bit like "fancy" key-value pairs and is common for getting information about a particular subject. Close the pattern about the same subject with a `.` again.

---

# Follow the graph

* In SQL this is when you usually address another table
* Basically a JOIN operation
* Good news: You do not have to worry about that

```SPARQL
?s a schema:Person ;
  schema:givenName "Adrian" ;
  schema:familyName "Gschwend" ;
*  schema:knows ?someoneelse .

* ?someoneelse schema:givenName ?givenName ;
  schema:familyName ?familyName .
```

This can be combined in very complex/powerful patterns

---

# Data Types

* RDF 1.1 supports data types, mostly XML inspired ones (XSD namespace)
    - `xsd:date`
    - `xsd:dateTime`
    - `xsd:float`
    - ...
    - default is `xsd:string`
* Should be used, especially when you want to filter efficiently
* Using datatypes that are not optimized can dramatically reduce query performance

---

# FILTER keyword

* Sometimes simple pattern matching is too restrictive or not enough
* For that we have the `FILTER` keywords
* It kicks out matches that do not comply to what you define in the FILTER, example:

```
  FILTER ( ?date >= "2016-01-01"^^xsd:date && ?date <= "2016-12-31"^^xsd:date )
```

---

# Languages

* We can filter for specific languages as well, very handy in Switzerland
* Can be combined to match by user preferences

```sparql
  FILTER(langMatches(lang(?aggregation), "DE"))
```

---

# How I work

* Start very simple
    - Assign base classes and/or attributes
    - Make sure you get what you expect
    - Add `FILTER` if necessary
* Understand your data
    - Open a sample URI in the browser, see if you get HTML with data
    - If you don't, ask the namespace owner to install [Trifid](https://github.com/zazuko/trifid) ;)
    - Understand the schema/ontology
    - If you do not get anything, use [SPARQL `DESCRIBE`](https://www.w3.org/TR/sparql11-query/#describe) in a second window to get similar results
    - `DESCRIBE <http://data.example.org/somewhere/something>`
* Follow the links in your graph
    - Follow the object that is a link
    - Get key/value pairs from the next subject
* Repeat

---

# Examples related to Switzerland Open Government Data

* Queries based on data from [FSO & Swisstopo](https://github.com/zazuko/fso-lod/blob/master/doc/eCH0071/sparql.md)
* Zazuko [aLOD](http://data.alod.ch/search/) - Archival Software Frontend
    - use developer console to see SPARQL queries that are executed
    - Open Source Software [Trifid](https://github.com/zazuko/trifid), [ZACK](https://github.com/zazuko/zack-search/)
* [Swisstopo](https://ld.geo.admin.ch/search/)

---

# Wikidata & SPARQL

* [Basic introduction](https://www.wikidata.org/wiki/Wikidata:SPARQL_query_service/queries)
* [Tons of examples](https://www.wikidata.org/wiki/Wikidata:SPARQL_query_service/queries/examples)

Note that Wikidata RDF is not the easiest to understand & start with.

---

# Getting help

* Have a look at examples, you will find a lot
* [Stackoverflow](https://stackoverflow.com/questions/tagged/sparql)
* My SPARQL skills gradually improved
* and now it feels like superpowers!

---

# More SPARQL (again, for at home)

* [ASK](https://www.w3.org/TR/sparql11-query/#ask) - does this pattern exist?
* [CONSTRUCT](https://www.w3.org/TR/sparql11-query/#construct) - create another GRAPH from my results, instead of a flat result-set structure
* [SPARQL 1.1 Update](http://www.w3.org/TR/sparql11-update/) - INSERT/UPDATE/DELETE data
* [SPARQL 1.1 Graph Store HTTP Protocol](http://www.w3.org/TR/sparql11-http-rdf-update/) - Load RDF dumps to Triplestores via simple HTTP API

---

# You want to read in the spec about

* [Aggregate Algebra](https://www.w3.org/TR/sparql11-query/#aggregateAlgebra) like `COUNT`
* [BIND](https://www.w3.org/TR/sparql11-query/#bind)
* [String operations](https://www.w3.org/TR/sparql11-query/#func-strings) - Data cleaning anyone?
* [Property Paths](https://www.w3.org/TR/sparql11-query/#PropertyPathPatterns)
* And pretty much most of the other stuff mentioned, like reasoning ;)

---

# Nice to know

* There is [GeoSPARQL](http://www.opengeospatial.org/standards/geosparql) for querying spatial data
* Many implementations provide Apache Solr/Lucene extensions for full-text search. However, they are proprietary extensions at the time writing. Example: [Apache Jena](https://jena.apache.org/documentation/query/text-query.html)
* Vendors start to integrate other features like [Machine Learning](https://www.stardog.com/docs/#_machine_learning) into SPARQL

---

# SPARQL implementations (selection)

* Apache [Fuseki](https://jena.apache.org/documentation/fuseki2/), [Docker](https://hub.docker.com/r/stain/jena-fuseki/)
* [Stardog](http://www.stardog.com/) - Commercial, very well documented & additional features, community license for free
* [Virtuoso](https://virtuoso.openlinksw.com/) - Dual licensed, OSS & commercial

