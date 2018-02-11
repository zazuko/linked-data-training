# Exercises

## Me, myself, and I 🙈

### Basic profile of yourself

Create a profile of your own data and a minimal social network with some persons you know. Use schema.org to find appropriate classes and vocabulary. Write it down in [Turtle](https://www.w3.org/TR/turtle/) syntax (also explained in the [RDF 1.1 Primer](https://www.w3.org/TR/rdf11-primer/#section-turtle)).

* Find the corresponding class for modelling a person

- Write down given name and family name
- Add some other attributes you might find in the appropriate schema.org class
- Save the file using the `*.ttl` extension

In the introduction slides you saw that you can either have an URI as an object of a triple or a [literal](https://www.w3.org/TR/rdf11-primer/#section-literal). Literals are used for everything that you want to store, like strings, numbers or specific datatypes like a date. If you can specify a certain data type, do it. This will enable smarter filters, in SPARQL, for example for date values. It is not necessary to state that something is of datatype string. RDF 1.1 assumes that [by default](https://www.w3.org/TR/turtle/#turtle-literals).

### Prefixes & BASE 

If not done yet, use the following constructs to make the file easier to read

* Relative IRIs using [prefixed names](https://www.w3.org/TR/turtle/#sec-iri) for vocabularies like schema.org. It is recommended to use the SPARQL version (the one without `@` in the beginning) so we can use the same prefix later in SPARQL. Note that the SPARQL version is currently not supported in RDF Translator listed in the next chapter, you have to use the Turtle-syntax in that case.
* Use the `BASE` definition to shortcut the URI of yourself

### Validation

* Validate your file and transform it to at least one other RDF serialization, use command line tools like [rapper](http://librdf.org/raptor/rapper.html) (see an old [blog post](http://strangelove.netlabs.org/semantic-web-basics/) of mine for samples) or online tools like [RDF Translator](http://rdf-translator.appspot.com/). Note that for RDF Validator you need to choose `N3` as input for Turtle.


* Try to understand at least [N-Triples](https://www.w3.org/TR/n-triples/) serialization of your data
* If you are in web tooling, have a look at [JSON-LD](https://json-ld.org/) as well. Copy the JSON-LD version and paste it on the [JSON-LD playground](https://json-ld.org/playground/) to serialize it back to N-Triples for example. Did you loose any of the information in between?
* Go back to schema.org [Person](https://schema.org/Person) and scroll down to the Examples section. Does your JSON-LD version  correspond with the examples at schema.org?
* What does the [structured data testing tool](https://search.google.com/structured-data/testing-tool) state from Google? Try the schema.org example and your version.
* How could you embed this information in a website for data you maintain (ideally automated)? Discuss this with your tutor and peers.

### Outgoing links

So far we only created some local data of ourselves in simple structures. Let us create some more complex structures that link to other things. Take your Person profile from before and add:

* An address. Have a look at the examples on schema.org
* Outgoing links to other persons, for example peers in your class, real or imaginary friends, anyone else you can think of. Try to find an appropriate predicate at schema.org.
* List at least two persons you know. For one person, create an instance of this person in the same file where you maintain your own data. For another person, link to RDF data available in the web. If you can't think of someone else, use http://ktk.netlabs.org/foaf#me.

Discuss the results with your peers and your tutor. Discuss what URI you used to define additional persons.

### Interlude: Cool URIs

You will spend a considerable amount of time talking about URIs and URI patterns. Many smart people wrote many different documents about why or why not specific patterns should be used. One of the most famous papers for this discussion is called [Cool URIs for the Semantic Web](https://www.w3.org/TR/cooluris/). It is a good idea to read this once you feel more comfortable with RDF and you start creating real data. Tim Berners-Lee also talked about this, still in the early days of the web (before 2000). You might enjoy the reading of [Cool URIs don't change](https://www.w3.org/Provider/Style/URI) as well.

In general you should try to make sure that:

* URIs stay the same and do not suddenly disappear when you update your data
* URIs do not clash. The U in URI stands for "Unique". If two distinct things get the same URI, you will have *very* confusing results querying this data in SPARQL or other ways!
* It is your namespace: When you publish data it should be within a namespace your organisation owns. It is for example a good idea to put data URIs somewhere else where your website sits, typically `www.something.org`. This greatly facilitates interoperability with "normal" web sites and gives you your own DNS-entry for sub domains like `data.something.org`.

### Blank nodes

You probably first used unique URIs for pointing to the address of the person. Sometimes this is a bit overkill, as you might not care about the URI of the address itself as it should always be assigned to the person and never pop up alone. For those  situations you can use something called a [blank node](https://www.w3.org/TR/turtle/#BNodes). You can find a better explanation of how it could be used in the [RDF 1.1 Primer](https://www.w3.org/TR/rdf11-primer/#section-blank-node).

* Re-write the address in your example with blank nodes

Note that some do not like blank nodes at all. There are certain issues that might come up when using blank nodes. However, for prototyping data structures we use blank nodes a lot, but this does not necessarily mean that we will use them as well in production. You can get an idea of possible issues by reading the [Wikipedia page](https://en.wikipedia.org/wiki/Blank_node) about blank nodes.

## SPARQL ✨

Creating data is one thing but properly querying it is where the fun starts. For that we will start with some basic SPARQL queries on top of our data from the examples before. There are many ways to start with SPARQL on your local system. We will introduce some of them, choose whatever fits you best. Note that there are quite SPARQL implementations available these days, both commercial and open source based. As long as they are supporting [SPARQL 1.1](https://www.w3.org/TR/sparql11-query/), you should be good to go.

SPARQL is basically the SQL equivalent of RDF. You will need it to do useful stuff on top of your data.

### Apache Jena

#### Command line Apache Jena

One of the free & open source reference implementations of SPARQL is maintained in the [Apache Jena](https://jena.apache.org/) project. All you need on your local system is a Java runtime environment and you are good to go. The documentation of Apache Jena provides its own tutorials, as a start have a look at the [SPARQL Tutorial](https://jena.apache.org/tutorials/sparql_query1.html) to get an idea of how to run SPARQL queries on your own system. 

If you use this way you will have a SPARQL query open in a text editor and execute your changes on the command line against a local RDF file, like our Turtle file from before.

Apache Jena also provides a so-called triplestore (in fact a quadstore ) as a standalone server. This implementation is called [Apache Jena Fuseki](https://jena.apache.org/documentation/fuseki2/) and can be downloaded at their [homepage](https://jena.apache.org/download/index.cgi) as well. Fuseki provides a web interface with a nice SPARQL query frontend, this makes it easier to work with larger data sets and it provides some extras as well for writing SPARQL queries (like automatic prefix completion). See the [Fuseki Quickstart](https://jena.apache.org/documentation/fuseki2/fuseki-quick-start.html) section for more information about getting it up and running on your system. 

#### Jena Fuseki Docker image

For those of you who do have Docker installed, you can run your own Fuseki endpoint on your local system very quickly. For that we will use the [stain/fuseki](stain/fuseki) docker image, see the documentation for the docker container and set it up accordingly. Once you are done, there should be a local Fuseki available on your system.

#### For everyone else

If you cannot setup any of this, your tutor will provide an instance of Fuseki on an external machine for the classroom.

### Basic Querying

Now it is time to start querying our data. Either load your file to Fuseki or use the in-memory query function to execute SPARQL queries against your data with the command line tools.

Start doing basic query patterns in the `WHERE` clause to find:

- All `schema:Person` in the file
- Given name & family name
- Re-use the `BASE` and `PREFIX` declarations from the Turtle file to make the SPARQL query easier to read

Now we realize it would be nice to have some more data like email addresses or phone numbers assigned to the persons. Add some more data to your file and load it again but no *not* add it on all persons you specified. Make sure that one person has an email and the other does not.

* Query the data again but include one of the newly introduced properties like email. What is the effect on your query? Why?
* Have a look at the SPARQL 1.1 specification about [Optional Pattern Matching](https://www.w3.org/TR/sparql11-query/#optionals) and fix your query accordingly so you get all `schema:Person` back again.

#### Matching specific values in strings, numbers & dates

We only have few persons in our sample data but it would still be nice to find a specific person in our data.

* Adjust the query in way that only a specific person gets found. Start with a triple pattern that simply sets the object to a specific string.
* Play around with this string, can you search for partial strings like this as well? Why or why not?
* Have a look at SPARQL [FILTER](https://jena.apache.org/tutorials/sparql_filters.html) & [string functions](https://www.w3.org/TR/sparql11-query/#func-strings) like `STRSTARTS` and `REGEX`. Note that the SPARQL 1.1 document does not have a very good introduction to filters, they are suddenly there in the text. Filters are super useful for many cases, it is worth getting comfortable with them. There are some [other examples](http://rdf.myexperiment.org/howtosparql?page=FILTER) for filtering numbers and dates.
* Try to filter partial results of names with by using `FILTER`.

### Follow the nose

In our `schema:Person` example we used links in the object to point to other persons we know. We now want to extend the example before and search all the persons the specific person we matched with the filter knows.

* Create a triple pattern that fetches the URI of the person this particular person knows. Most probably this means you have to follow the [schema:knows](https://www.w3.org/TR/sparql11-query/#func-strings) link in your data.
* This URI should now be attached to a variable you defined. Create an additional triple pattern that follows this link and displays all the data you have about this person. Alternatively simply specify which information you would like to get from it, like given name or phone number.
* Bonus: SPARQL 1.1 introduced so called [property paths](https://www.w3.org/TR/sparql11-query/#propertypaths). Can you rewrite the query in a way that you simply fetch the specific information you want about the person, without following the URI in an explicit triple pattern?

Following links is a typical pattern in Linked Data applications, it is often called "Follow your nose" as we simply follow links and discover more once we are at the new resource.

### Querying other SPARQL endpoints

One of the main concepts of Linked Data is to make sure that we do not duplicate data anymore everywhere, as it is mostly the case with other technologies. For that we will have to access data maintained by other groups sooner or later. Fortunately SPARQL has a `SERVICE` keyword that enables so called federated queries. Have a look at the [separate specification](https://www.w3.org/TR/sparql11-federated-query/) for it.

For the next query, we want to use this functionality. We have the following two endpoints:

**data.admin.ch**

* SPARQL frontend: http://data.admin.ch/sparql/
* SPARAL Endpoint: http://data.admin.ch/query
* Graph: https://linked.opendata.swiss/graph/eCH-0071
* Content: Historisiertet Gemeindeverzeichnis (Historicized Swiss Municipality Register)

**ld.geo.admin.ch**

* SPARQL frontend: https://ld.geo.admin.ch/sparql/


* SPARQL Endpoint: https://ld.geo.admin.ch/query
* Graph: none
* Content: Some basic statistical information & WKT Shapes of the municipalities

Task:

* Use a Swiss Municipality as a starting point to understand the structure of the data. For example [Biel/Bienne](http://classifications.data.admin.ch/municipality/371).
* Based on that municipality, try to find the URI for the municipality you live in (or any other municipality that is of interest to you).
* In case there are multiple `gont:municipalityVersion` of it, try to find the latest one by using SPARQL only. If your own municipality does not have versions, use Biel/Bienne.
* Use the `SERVICE` keyword to query the population of the municipality you selected in the ld.geo.admin.ch endpoint.
* Bonus: Plot the population either for multiple municipalities or for all the years you can find. You might do that using the Google Chart Plugin in the SPARQL frontend or by using the  using D3 & [D3-SPARQL](https://github.com/zazuko/d3-sparql).

### Supporting additional languages

Fortunately RDF & SPARQL were specified after we figured out that it would make sense to support more than one language in applications & data. It is straight forward to add the same property in multiple languages and query it accordingly in SPARQL.

* [Chapter 3.3](https://www.w3.org/TR/2014/REC-rdf11-concepts-20140225/#section-Graph-Literal) in the RDF 1.1 specification points to the [BCP47](https://tools.ietf.org/html/bcp47) RFC (something like W3C specifications but from an organisation called IETF). Can you find the correct language tags for:
  * German
  * German, Swiss edition
  * French, Swiss edition
  * Italian, Swiss edition
  * Bonus: Swiss German dialect
* Adjust your Turtle file with some additional properties in multiple languages. See the [RDF 1.1 Primer](https://www.w3.org/TR/turtle/#turtle-literals) for details, especially Example 11. If necessary just make up some additional triples that can easily be translated in additional languages.
* Create a SPARQL query that filters the triples you just defined for a certain language. See the [langMatches](https://www.w3.org/TR/sparql11-query/#func-langMatches) function in SPARQL.

### Bonus: Use Wikidata to get translations to many other languages

Wikidata provides an endless amount of data about many different topics. Among others you will find most if not all Swiss municipalities in Wikidata. Fortunately the data.admin.ch dataset links to the corresponding URI in Wikidata.

* Follow this URI and try to understand the basic Wikidata model. It is quite different to what you have seen so far. See the [Wikidata documentation](https://www.mediawiki.org/wiki/Wikidata_query_service/User_Manual#Basics_-_Understanding_Prefixes) for basics.
* Try to find out what other languages are available for the municipalities. Try to create a query within Wikidata that filters out a particular language. Try something fun like Japanese, Russian or Thai.
* Create a federated query (remember `SERVICE` keyword) to get the translation directly from the data.admin.ch SPARQL endpoint by using the Wikidata endpoint for translations.

### Content-Types

So far you either queried the data directly or used a web based SPARQL frontend. For using data in applications it might be useful to request a certain type of format of the results. For SPARQL SELECT queries, the following options are defined:

* [TSV & CSV](https://www.w3.org/TR/sparql11-results-csv-tsv/)
* [XML](http://www.w3.org/TR/rdf-sparql-XMLres/)
* [JSON](http://www.w3.org/TR/sparql11-results-json/)

You can query another format by specifying an appropriate `Accept`- header, for example by using curl:

​    `curl -H "Accept: text/csv" —data-urlencode query@query-file.rq http://mysparqlqueryendpoint/query`

Use one of the queries you created to get results in different formats back. Try to find the appropriate Accept mime-type in the specifications (search for media type, file type, content type or alike). If you do not have curl installed on your system, try it on a system of one of your peers.

This does also work for RDF serialisations in general, try the same header on the [Biel/Bienne](Biel/Bienne) resource and request it as [Turtle](https://en.wikipedia.org/wiki/Turtle_(syntax)) or [JSON-LD.](https://en.wikipedia.org/wiki/JSON-LD) Check the media types in the Wikipedia page for both formats.

### Check if a certain graph pattern exists

Sometimes all you want to know is if a certain graph pattern exists in your data. What you would like to have back is a yes or a no, or in computer terms a true or a false. SPARQL implements that by using the [ASK](https://www.w3.org/TR/sparql11-query/#ask) keyword.

* Take your Person profile and write a check that returns true, if a person has an email address and false, if there is no email address attached to the person.

## Converting data to RDF 🛀🏽

### OpenRefine

One of the well known tools for converting data to RDF is [OpenRefine](http://openrefine.org/). It provides some kind of graphical user interface to map existing data to RDF. While this is not necessarily the ideal tool for large datasets, we can use it to transform lists of data to RDF.

It is recommended to use a release that ships OpenRefine with the RDF extension installed, as the current release of the RDF extension does not properly work with the latest OpenRefine version out of the box. You can get a recent build on [Github](https://github.com/stkenny/OpenRefine/releases).

OpenRefine can do much more than just export RDF from tabular, XML and JSON data. But in our case we only focus on that functionality. If you are not part of a class you might want to read some [existing tutorials](http://dataplatform.co.uk/2015/07/13/turning-flat-data-into-semantic-data-with-open-refine-and-the-rdf-extension.html) about how to transform data to RDF. Within your class, the tutor should give a basic walkthrough.

### Improving the data

As you noticed the data we converted is not perfect. There is a predicate in the data that contains many names, separated by comma. With the support of the whole class and your tutor we want to improve this dataset:

* Each person should become its own resource (URI)
* The main resource should point to this new URI
* Bonus: Delete the old property with all the names in one string

To get there, we need some advanced concepts in SPARQL, have a look at the specifications and work it out in the classroom:

* [CONSTRUCT](https://www.w3.org/TR/sparql11-query/#construct): Returns a graph instead of a result set (we always used SELECT and got a list back so far)
* [BIND](https://www.w3.org/TR/sparql11-query/#bind): Will be used to create a new string and in the end a new URI for the person object
* [CONCAT](https://www.w3.org/TR/sparql11-query/#func-concat): To create a new string and combine it with some data from WHERE
* [IRI](https://www.w3.org/TR/sparql11-query/#func-iri) and [ENCODE_FOR_IRI](https://www.w3.org/TR/sparql11-query/#func-encode) : To create a proper URI out of the string created above
* [DELETE/INSERT](DELETE/INSERT) in the SPARQL Update Specification. That might a bit hardcore for some but it gives you an idea of how to update existing data in RDF as well.

When everything goes right, we have a nicely built graph as a result of this cleanup procedure, not just key-value RDF.

