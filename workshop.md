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

# Graph algorithms

# Tasks for participants