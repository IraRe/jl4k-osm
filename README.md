## jl4k-osm

1. Run nodes.cypher first to import nodes from the maps.xml
2. Run ways.cypher to connect nodes with ways relationships.

# JL4K how to start

1. Install Neo4j Desktop: https://neo4j.com/download-neo4j-now/
2. Create new empty local graph
3. Configure the graph by clicking on “Manage” button
4. Go to “Plugins” and install APOC and Graph Algorithms
5. Go to “Settings” 
6. Change/add following settings:
```
    # Whether requests to Neo4j are authenticated.
    # To disable authentication, uncomment this line
    dbms.security.auth_enabled=false
    apoc.import.file.enabled=true
```
7. Start the database
8. Open the installation folder by clicking on “Open folder” 
9. Copy the cypher scripts `nodes.cypher` and `ways.cypher` into the installation folder
10. Copy the `map.xml` file into the import folder
11. Open Terminal
12. run `cat nodes.cypher | bin/cypher-shell` and `cat ways.cypher | bin/cypher-shell` in exactly this order


# Troubleshooting

`Connection refused` may happen if the database is not running.

`The client is unauthorized due to authentication failure` happens if you have the authentication enabled and don’t provide proper credentials. 

`There is no precedure with the name apoc.load.xml registered for this database instance.` happens if you don’t install the Apoc plugin.

`Failed to invoce procedure apoc.load.xml: Caused by: java.lang.RuntimeException: Import from files not enabled.` occurs if you don’t add `apoc.import.file.enabled=true` to you settings
