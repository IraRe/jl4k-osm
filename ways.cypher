call apoc.load.xml('file:///map.xml', '//way', {}, false) 
    yield value as doc
    with doc._children as children, doc.id as id
    with filter(child IN children WHERE child._type = 'nd') as refs, id
    foreach (idx in range(0,size(refs)-2) |
    	create (:Pair {first:refs[idx].ref, second:refs[idx+1].ref, id:id}));

match (p:Pair)
match (f:OsmNode) where f.id = p.first
match (s:OsmNode) where s.id = p.second
create (f)-[:WAY {id:p.id}]->(s)
delete p;

match (p:Pair) delete p;

call apoc.load.xml('file:///map.xml', '//way', {}, false) 
    yield value as doc
    match ()-[w:WAY]->() where w.id = doc.id
    with filter(child in doc._children where child._type = 'tag') as tags, doc.id as id
    unwind tags as tag
    	create (t:Tag {id:id, key:tag.k, value:tag.v});

match (t:Tag {key:'maxspeed'})
match ()-[w:WAY]->() where w.id = t.id
set w.maxspeed = t.value;

match (t:Tag {key:'maxspeed'}) delete t;

match (t:Tag {key:'name'})
match ()-[w:WAY]->() where w.id = t.id
set w.name = t.value;

match (t:Tag {key:'name'}) delete t;

match (t:Tag {key:'operator'})
match ()-[w:WAY]->() where w.id = t.id
set w.operator = t.value;

match (t:Tag {key:'operator'}) delete t;

match (t:Tag {key:'passenger_lines'})
match ()-[w:WAY]->() where w.id = t.id
set w.passengerLines = t.value;

match (t:Tag {key:'passenger_lines'}) delete t;

match (t:Tag {key:'railway'})
match (a)-[w:WAY]->(b) where w.id = t.id
merge (a)-[:RAILWAY {id:t.id, type:t.value}]->(b);

match (t:Tag {key:'railway'}) delete t;

match (t:Tag {key:'railway:lzb'}) delete t;

match (t:Tag {key:'railway:preferred_direction'})
match (a)-[w:WAY]->(b) where w.id = t.id
set w.preferredDirection = t.value;

match (t:Tag {key:'railway:preferred_direction'}) delete t;

match (t:Tag {key:'railway:pzb'}) delete t;

match (t:Tag {key:'railway:track_ref'}) delete t;

match (t:Tag {key:'railway:traffic_mode'}) delete t;

match (t:Tag {key:'ref'}) delete t;

match (t:Tag {key:'usage'}) delete t;

match (t:Tag {key:'voltage'})
match (a)-[w:WAY]->(b) where w.id = t.id
set w.voltage = t.value;

match (t:Tag {key:'voltage'}) delete t;

match (t:Tag {key:'workrules'}) delete t;

match (t:Tag {key:'bicycle'})
match (a)-[w:WAY]->(b) where w.id = t.id
set w.bicycle = t.value;

match (t:Tag {key:'bicycle'}) delete t;

match (t:Tag {key:'foot'})
match (a)-[w:WAY]->(b) where w.id = t.id
set w.foot = t.value;

match (t:Tag {key:'foot'}) delete t;

match (t:Tag {key:'highway'})
match (a)-[w:WAY]->(b) where w.id = t.id
merge (a)-[:HIGHWAY {id:t.id, type:t.value}]->(b);

match (t:Tag {key:'highway'}) delete t;

match (t:Tag {key:'segregated'})
match (a)-[w:WAY]->(b) where w.id = t.id
set w.segregated = t.value;

match (t:Tag {key:'segregated'}) delete t;

match (t:Tag {key:'surface'})
match (a)-[w:WAY]->(b) where w.id = t.id
set w.surface = t.value;

match (t:Tag {key:'surface'}) delete t;

match (t:Tag {key:'area'}) delete t;

match (t:Tag {key:'access'})
match (a)-[w:WAY]->(b) where w.id = t.id
set w.access = t.value;

match (t:Tag {key:'access'}) delete t;

match (t:Tag {key:'lit'}) delete t;

match (t:Tag {key:'oneway'})
match (a)-[w:WAY]->(b) where w.id = t.id
set w.oneway = t.value;

match (t:Tag {key:'landuse'}) delete t;

match (t:Tag {key:'lanes'})
match (a)-[w:WAY]->(b) where w.id = t.id
set w.lanes = t.value;

match (t:Tag {key:'lanes'}) delete t;

match (t:Tag {key:'bus'})
match (a)-[w:WAY]->(b) where w.id = t.id
merge (a)-[:BUS {id:t.id}]->(b);

match (t:Tag {key:'bus'}) delete t;

match (t:Tag {key:'tunnel'})
match (a)-[w:WAY]->(b) where w.id = t.id
merge (a)-[:TUNNEL {id:t.id, type:t.value}]->(b);

match (t:Tag {key:'tram'})
match (a)-[w:WAY]->(b) where w.id = t.id
merge (a)-[:TRAM {id:t.id}]->(b);

match (t:Tag {key:'bicycle_road'})
match (a)-[w:WAY]->(b) where w.id = t.id
merge (a)-[:BICYCLE_ROAD {id:t.id}]->(b);

match (t:Tag) delete t;
