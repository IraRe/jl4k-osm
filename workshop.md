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
`create (n:Student) set n.name = 'Max Mustermann' set n.age = 13 return n`
```
create (n:Student) 
	set n.name = toLower('Max Mustermann')
    set n.age = 13 
return n
```

### relationships
`create ()-[:NEXT]->()`

## read
`match (n) return n limit 10`
`match (n:Student) return n`
`match (n:Student {name:'Max Mustermann'}) return n`
`match (n:Student) where n.name = 'Max Mustermann' return n`
`match (n:Student) where n.name starts with 'Max' return n`
`match (n:Student) where n.name contains 'sterman' return n`
`match (n:Student) where n.age > 13 return n`

## update
`match (n:Student) set n:Person return n`
`create (t:Teacher {name:'Martina Mustermann'})`
`match (t:Teacher) set t.age=32 return t`
`match (n:Student) set n.school = 'Max-Ernst-Gymnasium' return n`
`match (n:Student {name: 'Max Mustermann'}) set n.name = 'Maximilian Mustermann' return n`

## delete
`match (n {name: 'Martina Mustermann'}) delete n`
`match (n) where labels(n) = [] delete n`

# More complex queries

# Graph algorithms

# Tasks for participants