# Introduction
1. Explain graphs on a flip chart.
2. Explain basic cypher syntax on a flip chart.
3. Cypher Refcard: https://neo4j.com/docs/cypher-refcard/current/

# CRUD
## create

### nodes
`create ()`
`create (n) return n`
`create (n:Student) return n`
`create (n:Student {name:'Jane Doe', age: 14}) return n`
`create (n:Student) set n.name = 'Max Mustermann', n.age = 13 return n`
`create (n:Student:Person) set n.name = 'Max Mustermann' set n.age = 13 return n`
```
create (n:Student) 
	set n.name = toLower('Max Mustermann')
    set n.age = 13 
return n
```

### relationships
`create ()-[:NEXT]->()`
`create (a)-[r:NEXT]->(b) return a,r,b`
```
create (p:Person:Student {name:"Alex Schmidt"})-[r:VISITS {since:"1.09.2014"}]->(s:School {name:"Einstein-Gymnasium"}) 
return p,r,s
```

## read

### nodes
`match (n) return n limit 10`
`match (n:Student) return n`
`match (n:Student {name:'Max Mustermann'}) return n`
`match (n:Student) where n.name = 'Max Mustermann' return n`
`match (n:Student) where n.name starts with 'Max' return n`
`match (n:Student) where n.name contains 'sterman' return n`
`match (n:Student) where n.age > 13 return n`

### relationships
`match (n)--() return n limit 5`
`match ()-[r]-() return r limit 5`
`match (a)-[r:VISITS]->(b) return a,r,b`
`match (a)-[r:WAY]->(b) where r.maxspeed = "50" return a,r,b limit 5` 

## update

### nodes
`match (n:Student) set n:Person return n`
`create (t:Teacher {name:'Martina Mustermann'})`
`match (t:Teacher) set t.age=32 return t`
`match (n:Student) set n.school = 'Max-Ernst-Gymnasium' return n`
`match (n:Student {name: 'Max Mustermann'}) set n.name = 'Maximilian Mustermann' return n`

## relationships
`match (a)-[r:VISITS]->(b) set r.since = "24.08.2014" return a,r,b`

## delete

### isolated nodes
`match (n {name: 'Martina Mustermann'}) delete n`
`match (n) where labels(n) = [] delete n`

### nodes with relationships
`match (s:School) where s.name = "Einstein-Gymnasium" detach delete s`

### relationships
`match ()-[r:NEXT]->() delete r`

# More complex queries

## Longest tram path
```
match p=()-[r:TRAM*]->() 
return p, length(p) as pathLength 
    order by pathLength desc limit 3
```

```
match p=(start:Platform)-[r:TRAM*]->(stop:Platform) 
return start, stop, length(p) as pathLength 
    order by pathLength desc limit 3
```

```
match p=(start:Platform)-[r:TRAM*]->(stop:Platform) 
	where id(start)<>id(stop)
return start, stop, length(p) as pathLength, nodes(p) as stops
    order by pathLength desc limit 3
```

## 5 neares restaurants
```
call apoc.spatial.geocode('Brühl, Wolkenburgstraße 18') yield latitude as lat, longitude as lon
    with point({latitude:lat, longitude:lon}) as home
match (r:Restaurant) 
with r.name as restaurant, 
    point({latitude:toFloat(r.latitude), longitude:toFloat(r.longitude)}) as p, 
    home
return restaurant, distance(home, p) as dist order by dist limit 5
```

# Graph algorithms

## Shortest path

```
match p=(n:Stop {name:'Max-Ernst-Museum'})-[:WAY*1..100]-(m:Stop {name:'Kölnstraße/Comesstraße'}) 
    return p limit 25
```

```
match p=shortestPath((n:Stop {name:'Max-Ernst-Museum'})-[:WAY*1..100]-(m:Stop {name:'Kölnstraße/Comesstraße'})) 
    return p limit 25
```
### Task
Find a shortest path between the stop 'Brühl Bahnhof' and 'Max-Ernst-Museum'

## PageRank

# Tasks for participants

```
match path = (p1:Person {name:'Laura'})-[r:FRIEND*1..2]->(p2:Person)
unwind nodes(path) as f
    match (f)-[l:LIKES]->(n:OsmNode) where id(f) <> id(p1) 
    with collect(distinct f) as friends
unwind friends as friend
    match (friend)-[l:LIKES]->(n:OsmNode)
    return n.name, count(l) as likes order by likes desc
```