call apoc.load.xml('file:///map.xml', '//node', {}, false) 
    yield value as doc 
with doc.id as id,
    doc.lon as longitude, 
	doc.lat as latitude, 
	doc._children as tags
create (n:OsmNode {longitude:longitude, latitude:latitude, id:id})
foreach (tag in tags | 
	merge (t:Tag {key:tag.k, value:tag.v})
    create (n)-[:HAS_TAG]->(t));

match (t:Tag {key: "public_transport", value: "stop_position"})<-[:HAS_TAG]-(n:OsmNode) 
    set n :Stop;

match (t:Tag {key: "public_transport", value: "stop_position"})<-[:HAS_TAG]-(n:Stop) 
    detach delete t;

match (t:Tag {key:'name'})<-[:HAS_TAG]-(n:OsmNode) 
	set n.name = t.value;

match (t:Tag {key:'name'})<-[:HAS_TAG]-(n:OsmNode) 
	detach delete t;

match (t:Tag {key:"barrier"})<-[:HAS_TAG]-(n:OsmNode) 
	set n:Barrier
    set n.name = t.value;

match (t:Tag {key:"barrier"})<-[:HAS_TAG]-(n:OsmNode) 
	detach delete t;

match (t:Tag {key:'local_ref'})<-[:HAS_TAG]-(n:OsmNode)
	set n.localRef = t.value;

match (t:Tag {key:'local_ref'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'network', value:'VRS'})<-[:HAS_TAG]-(n:OsmNode)
	set n:VRS;

match (t:Tag {key:'network', value:'VRS'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'network', value:'CashPool'})<-[:HAS_TAG]-(n:OsmNode)
	set n.cashPool = true;

match (t:Tag {key:'network', value:'CashPool'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'operator'})<-[:HAS_TAG]-(n:OsmNode)
	set n.operator = t.value;

match (t:Tag {key:'operator'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway', value:'stop'})<-[:HAS_TAG]-(s:Stop)
	set s:Railway;

match (t:Tag {key:'railway', value:'stop'})<-[:HAS_TAG]-(s:Stop)
	detach delete t;

match (t:Tag {key:'ref'})<-[:HAS_TAG]-(n:OsmNode) 
	set n.ref = t.value;

match (t:Tag {key:'ref'})<-[:HAS_TAG]-(n:OsmNode) 
	detach delete t;

match (t:Tag {key:'train'})<-[:HAS_TAG]-(n:OsmNode) 
	set n:Train;

match (t:Tag {key:'train'})<-[:HAS_TAG]-(n:OsmNode) 
	detach delete t;

match (t:Tag {key:'ref:VRS'})<-[:HAS_TAG]-(n:OsmNode)
	set n.refVRS = t.value;

match (t:Tag {key:'ref:VRS'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'tram'})<-[:HAS_TAG]-(n:OsmNode) 
	set n:Tram;

match (t:Tag {key:'tram'})<-[:HAS_TAG]-(n:OsmNode) 
	detach delete t;

match (t:Tag {key:'VRS:gemeinde'})<-[:HAS_TAG]-(n:OsmNode)
	set n.vrsGemeinde = t.value;

match (t:Tag {key:'VRS:gemeinde'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'VRS:name'})<-[:HAS_TAG]-(n:OsmNode)
	set n.vrsName = t.value;

match (t:Tag {key:'VRS:name'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'VRS:ortsteil'})<-[:HAS_TAG]-(n:OsmNode)
	set n.vrsOrtsteil = t.value;

match (t:Tag {key:'VRS:ortsteil'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'VRS:ref'})<-[:HAS_TAG]-(n:OsmNode)
	set n.vrsRef = t.value;

match (t:Tag {key:'VRS:ref'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (n) where exists(n.refVRS) 
	set n.vrsRef = n.refVRS 
    remove n.refVRS;

match (t:Tag {key:'wheelchair'})<-[:HAS_TAG]-(n:OsmNode)
	set n.wheelchair = t.value;

match (t:Tag {key:'wheelchair'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'wheelchair:description'})<-[:HAS_TAG]-(n:OsmNode)
	set n.wheelchairDescription = t.value;

match (t:Tag {key:'wheelchair:description'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'crossing'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Crossing
    set n.crossing = t.value;

match (t:Tag {key:'crossing'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway', value:'level_crossing'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Railway:LevelCrossing;

match (t:Tag {key:'railway', value:'level_crossing'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway', value:'switch'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Railway:Switch;

match (t:Tag {key:'railway', value:'switch'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'highway', value:'traffic_signals'})<-[:HAS_TAG]-(n:OsmNode) 
	set n:Highway:TrafficSignals;

match (t:Tag {key:'highway', value:'traffic_signals'})<-[:HAS_TAG]-(n:OsmNode) 
	detach delete t;

match (t:Tag {key:'bus'})<-[:HAS_TAG]-(n:OsmNode) 
	set n:Bus;

match (t:Tag {key:'bus'})<-[:HAS_TAG]-(n:OsmNode) 
	detach delete t;

match (t:Tag {key:'highway', value:'bus_stop'})<-[:HAS_TAG]-(n:OsmNode) 
	set n:Highway:Stop:Bus;

match (t:Tag {key:'highway', value:'bus_stop'})<-[:HAS_TAG]-(n:OsmNode) 
	detach delete t;

match (t:Tag {key:'note'})<-[:HAS_TAG]-(n:OsmNode)
	set n.note = t.value;

match (t:Tag {key:'note'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'ref:AST'})<-[:HAS_TAG]-(n:Highway:Stop) 
	set n.refAST = t.value;

match (t:Tag {key:'ref:AST'})<-[:HAS_TAG]-(n:Highway:Stop) 
	detach delete t;

match (t:Tag {key:'shared_taxi'})<-[:HAS_TAG]-(n:OsmNode) 
	set n:SharedTaxi;

match (t:Tag {key:'shared_taxi'})<-[:HAS_TAG]-(n:OsmNode) 
	detach delete t;

match (t:Tag {key:'ele'})<-[:HAS_TAG]-(n:OsmNode)
	set n.ele = t.value;

match (t:Tag {key:'ele'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'is_in'})<-[:HAS_TAG]-(n:OsmNode) 
	set n.description = t.value;

match (t:Tag {key:'is_in'})<-[:HAS_TAG]-(n:OsmNode) 
	detach delete t;

match (t:Tag {key:'is_in:country_code'})<-[:HAS_TAG]-(n:OsmNode)
	create (n)-[:IS_IN]->(c:Country {code:t.value});

match (t:Tag {key:'is_in:country_code'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'is_in:iso_3166_2'}) detach delete t;

match (t:Tag) where t.key starts with 'name:' detach delete t;

match (t:Tag {key:'openGeoDB:community_identification_number'})<-[:HAS_TAG]-(n:OsmNode)
	set n.communityIdentificationNumber = t.value;

match (t:Tag {key:'openGeoDB:community_identification_number'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'openGeoDB:license_plate_code'})<-[:HAS_TAG]-(n:OsmNode)
	set n.licensePlateCode = t.value
    detach delete t;

match (t:Tag {key:'openGeoDB:loc_id'})<-[:HAS_TAG]-(n:OsmNode)
	set n.locId = t.value
    detach delete t;

match (t:Tag {key:'openGeoDB:telephone_area_code'})<-[:HAS_TAG]-(n:OsmNode)
	set n.locId = t.value
    detach delete t;

match (t:Tag {key:'place', value:'town'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Town
    detach delete t;

match (t:Tag {key:'population'})<-[:HAS_TAG]-(n:OsmNode)
	set n.population = t.value
    detach delete t;

match (t:Tag {key:'postal_code'})<-[:HAS_TAG]-(n:OsmNode)
	set n.postalCode = t.value;

match (t:Tag {key:'postal_code'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'wikidata'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'wikipedia'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'access:night'})<-[:HAS_TAG]-(n:OsmNode)
	set n.accessNight = t.value;

match (t:Tag {key:'access:night'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'description'})<-[:HAS_TAG]-(n:OsmNode)
	set n.description = t.value;
	
match (t:Tag {key:'description'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'foot'})<-[:HAS_TAG]-(n:OsmNode)
	set n.foot = t.value;

match (t:Tag {key:'foot'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'bollard'})<-[:HAS_TAG]-(n:OsmNode)
	set n.type = t.value;

match (t:Tag {key:'bollard'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'tourism', value:'hotel'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Hotel;

match (t:Tag {key:'tourism', value:'hotel'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'leisure', value:'pitch'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Pitch;

match (t:Tag {key:'leisure', value:'pitch'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'sport'})<-[:HAS_TAG]-(n:OsmNode)
	set n.sport = t.value;

match (t:Tag {key:'sport'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'website'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'addr:city'})<-[r:HAS_TAG]-(n:OsmNode) 
	set t:City
    set t.name = t.value
    create (n)-[:ADDR {type:'city'}]->(t)
    remove t:Tag
    remove t.key
    remove t.value
    delete r;

match (c:City) set c.name = 'Brühl';

match (t:Tag {key:'addr:housenumber'})<-[r:HAS_TAG]-(n:OsmNode)
	set t:Housenumber
    create (n)-[:ADDR {type:'housenumber'}]->(t)
    delete r;

match (h:Housenumber) remove h.key remove h:Tag;

match (t:Tag {key:'addr:postcode'})<-[r:HAS_TAG]-(n:OsmNode)
	set t:Postcode
    create (n)-[:ADDR {type:'postcode'}]->(t)
    delete r;

match (t:Postcode) remove t.key remove t:Tag;

match (t:Tag {key:'addr:street'})<-[r:HAS_TAG]-(n:OsmNode)
	set t:Street
    create (n)-[:ADDR {type:'street'}]->(t)
    delete r;

match (s:Street) remove s.key remove s:Tag;

match (t:Tag {key:'amenity', value:'post_office'})<-[:HAS_TAG]-(n:OsmNode)
	set n:PostOffice;

match (t:Tag {key:'amenity', value:'post_office'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'opening_hours'})<-[:HAS_TAG]-(n:OsmNode) 
	set n.openingHours = t.value;

match (t:Tag {key:'opening_hours'})<-[:HAS_TAG]-(n:OsmNode) 
	detach delete t;

match (t:Tag {key:'bicycle'})<-[:HAS_TAG]-(n:OsmNode)
	set n.bicycle = t.value;

match (t:Tag {key:'bicycle'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'emergency', value:'yes'})<-[:HAS_TAG]-(n:OsmNode)
	set n.emergency = t.value;

match (t:Tag {key:'emergency', value:'yes'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'highway', value:'mini_roundabout'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Highway:Roundabout
    detach delete t;

match (t:Tag {key:'addr:country'})<-[r:HAS_TAG]-(n:OsmNode)
match (c:Country)
	create (n)-[:ADDR {type:'country'}]->(c)
    delete r;

match (t:Tag {key:'addr:country'}) delete t;

match (t:Tag {key:'amenity', value:'kindergarten'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Kindergarten;

match (t:Tag {key:'amenity', value:'kindergarten'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'phone'})<-[:HAS_TAG]-(n:OsmNode)
	set n.phone = t.value;

match (t:Tag {key:'phone'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'historic', value:'memorial'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Memorial;

match (t:Tag {key:'historic', value:'memorial'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'start_date'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'natural'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Tree;

match (t:Tag {key:'natural'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;
	
match (t:Tag {key:'amenity', value:'restaurant'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Restaurant;

match (t:Tag {key:'amenity', value:'restaurant'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'smoking'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'toilets:wheelchair'})<-[:HAS_TAG]-(n:OsmNode)
	set n.toiletsWheelchair = t.value;

match (t:Tag {key:'toilets:wheelchair'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'entrance', value:'yes'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Entrance;

match (t:Tag {key:'entrance', value:'yes'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'shop'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Shop
    set n.type = t.value;

match (t:Tag {key:'shop'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag)<-[:HAS_TAG]-(n:OsmNode) where t.key starts with 'contact:'
	detach delete t;

match (t:Tag {key:'toilets'})<-[:HAS_TAG]-(n:OsmNode) 
	set n.toilets = t.value;

match (t:Tag {key:'toilets'})<-[:HAS_TAG]-(n:OsmNode) 
	detach delete t;

match (t:Tag {key:'amenity', value:'car_sharing'})<-[:HAS_TAG]-(n:OsmNode) 
	set n:CarSharing
    detach delete t;

match (t:Tag {key:'amenity', value:'telephone'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Telephone;

match (t:Tag {key:'amenity', value:'telephone'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'library'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Library
    detach delete t;

match (t:Tag {key:'ref:isil'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'amenity', value:'bank'})<-[:HAS_TAG]-(n:OsmNode)
    set n:Bank;

match (t:Tag {key:'amenity', value:'bank'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'atm'})<-[:HAS_TAG]-(n:OsmNode)
    set n:ATM;

match (t:Tag {key:'atm'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'amenity', value:'toilets'})<-[:HAS_TAG]-(n:OsmNode)
    set n:Toilets;

match (t:Tag {key:'amenity', value:'toilets'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'amenity', value:'cinema'})<-[:HAS_TAG]-(n:OsmNode)
    set n:Cinema
    detach delete t;

match (t:Tag {key:'open_air'})<-[:HAS_TAG]-(n:OsmNode)
    set n.openAir = t.value
    detach delete t;

match (t:Tag {key:'highway', value:'turning_circle'})<-[:HAS_TAG]-(n:OsmNode)
    set n:Highway:TurningCircle;

match (t:Tag {key:'highway', value:'turning_circle'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'traffic_calming'})<-[:HAS_TAG]-(n:OsmNode)
    set n.trafficCalming = t.value;

match (t:Tag {key:'traffic_calming'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'cycle_network'})<-[:HAS_TAG]-(n:OsmNode)
	set n.cycleNetwork = t.value;

match (t:Tag {key:'cycle_network'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'expected_rcn_route_relations'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'rcn_ref'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'highway', value:'crossing'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Highway:Crossing;

match (t:Tag {key:'highway', value:'crossing'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'leisure', value:'sports_centre'})<-[:HAS_TAG]-(n:OsmNode)
	set n:SportsCentre
    detach delete t;

match (t:Tag {key:'amenity', value:'pharmacy'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Pharmacy;

match (t:Tag {key:'amenity', value:'pharmacy'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'dispensing'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'fuel'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Fuel
    detach delete t;

match (t:Tag {key:'highway', value:'passing_place'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Highway:PassingPlace
    detach delete t;

match (t:Tag {key:'amenity', value:'cafe'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Cafe;

match (t:Tag {key:'amenity', value:'cafe'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'level'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'cuisine'})<-[:HAS_TAG]-(n:OsmNode)
	set n.cuisine = t.value;

match (t:Tag {key:'cuisine'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'outdoor_seating'})<-[:HAS_TAG]-(n:OsmNode)
	set n.outdoorSeating = t.value;

match (t:Tag {key:'outdoor_seating'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'public_transport', value:'platform'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Platform;

match (t:Tag {key:'public_transport', value:'station'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Station;

match (t:Tag {key:'public_transport'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'razed:railway'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'source'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'post_box'})<-[:HAS_TAG]-(n:OsmNode)
	set n:PostBox;

match (t:Tag {key:'amenity', value:'post_box'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'recycling'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Recycling;

match (t:Tag {key:'amenity', value:'recycling'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'parking'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Parking;

match (t:Tag {key:'amenity', value:'parking'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'highway', value:'stop'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Highway:Stop;

match (t:Tag {key:'highway', value:'stop'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'shelter'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Shelter;

match (t:Tag {key:'shelter'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'recycling:glass'})<-[:HAS_TAG]-(n:OsmNode)
	set n.glass = t.value;

match (t:Tag {key:'recycling:glass'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'recycling_type'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Container;

match (t:Tag {key:'recycling_type'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'police'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Police
    detach delete t;

match (t:Tag {key:'disused:amenity'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Disused
    detach delete t;

match (t:Tag {key:'alt_name'})<-[:HAS_TAG]-(n:OsmNode)
	set n.alternativeName = t.value;

match (t:Tag {key:'alt_name'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'fast_food'})<-[:HAS_TAG]-(n:OsmNode)
	set n:FastFood;

match (t:Tag {key:'amenity', value:'fast_food'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'location'})<-[:HAS_TAG]-(n:OsmNode)
	set n.location = t.value
    detach delete t;

match (t:Tag {key:'religion'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'motorcar'})<-[:HAS_TAG]-(n:OsmNode)
	set n.motorcar = t.value;

match (t:Tag {key:'motorcar'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag)<-[:HAS_TAG]-(n:OsmNode) 
	where t.key starts with 'removed:'
	detach delete t;

match (t:Tag {key:'amenity', value:'vending_machine'})<-[:HAS_TAG]-(n:OsmNode) 
	set t:VendingMachine;

match (t:Tag {key:'amenity', value:'vending_machine'})<-[:HAS_TAG]-(n:OsmNode) 
	detach delete t;

match (t:Tag {key:'type'})<-[:HAS_TAG]-(n:OsmNode) 
	set n.type = t.value;

match (t:Tag {key:'type'})<-[:HAS_TAG]-(n:OsmNode) 
	detach delete t;

match (t:Tag {key:'vending'})<-[:HAS_TAG]-(n:OsmNode) 
	set n:Vending
    set n.kind = t.value
    detach delete t;

match (t:Tag {key:'name_1'})<-[:HAS_TAG]-(n:OsmNode) 
	set n.name = t.value
    detach delete t;

match (t:Tag {key:'operator:VRS'})<-[:HAS_TAG]-(n:OsmNode) 
	set n.operator = t.value
    detach delete t;

match (t:Tag {key:'shop:VRS'}) detach delete t;

match (t:Tag {key:'amenity', value:'pub'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Pub;

match (t:Tag {key:'amenity', value:'pub'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway', value:'crossing'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Railway:Crossing;

match (t:Tag {key:'railway', value:'crossing'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'bench'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Bench;

match (t:Tag {key:'amenity', value:'bench'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'motor_vehicle'})<-[:HAS_TAG]-(n:OsmNode)
	set n.motorVehicle = t.value;

match (t:Tag {key:'motor_vehicle'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'tactile_paving'})<-[:HAS_TAG]-(n:OsmNode)
	set n.tactilePaving = t.value;

match (t:Tag {key:'tactile_paving'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'brand'})<-[:HAS_TAG]-(n:OsmNode)
	set n.brand = t.value
    detach delete t;

match (t:Tag)<-[:HAS_TAG]-(n:OsmNode)
	where t.key starts with 'ref:'
	detach delete t;

match (t:Tag {key:'entrance', value:'main'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Entrance:Main;

match (t:Tag {key:'entrance', value:'emergency_ward'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Entrance:EmergencyWard;

match (t:Tag {key:'entrance'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'grit_bin'})<-[:HAS_TAG]-(n:OsmNode)
	set n:GritBin;

match (t:Tag {key:'amenity', value:'grit_bin'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'backrest'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Backrest;

match (t:Tag {key:'backrest'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'material'})<-[:HAS_TAG]-(n:OsmNode)
	set n.material = t.value;

match (t:Tag {key:'material'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'seats'})<-[:HAS_TAG]-(n:OsmNode)
	set n.seats = t.value;

match (t:Tag {key:'seats'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'access'})<-[:HAS_TAG]-(n:OsmNode)
	set n.access = t.value;

match (t:Tag {key:'access'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'veterinary'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Veterinary detach delete t;

match (t:Tag {key:'amenity', value:'atm'})<-[:HAS_TAG]-(n:OsmNode)
	set n:ATM;

match (t:Tag {key:'amenity', value:'atm'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'crossing_ref'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Zebra;

match (t:Tag {key:'crossing_ref'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'fountain'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Fountain;

match (t:Tag {key:'amenity', value:'fountain'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'ice_cream'})<-[:HAS_TAG]-(n:OsmNode)
	set n:IceCream detach delete t;

match (t:Tag {key:'emergency', value:'fire_hydrant'})<-[:HAS_TAG]-(n:OsmNode)
	set n:FireHydrant;

match (t:Tag {key:'emergency', value:'fire_hydrant'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'fire_hydrant:diameter'})<-[:HAS_TAG]-(n:OsmNode)
	set n.diameter = t.value;

match (t:Tag {key:'fire_hydrant:diameter'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'fire_hydrant:position'})<-[:HAS_TAG]-(n:OsmNode)
	set n.position = t.value;

match (t:Tag {key:'fire_hydrant:position'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'fire_hydrant:position:sidewalks'})<-[:HAS_TAG]-(n:OsmNode)
	set n.positionSidewalks = t.value;

match (t:Tag {key:'fire_hydrant:position:sidewalks'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'fire_hydrant:type'})<-[:HAS_TAG]-(n:OsmNode)
	set n.type = t.value;

match (t:Tag {key:'fire_hydrant:type'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'power'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Substation;

match (t:Tag {key:'power'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'noexit'})<-[:HAS_TAG]-(n:OsmNode)
	set n:NoExit detach delete t;

match (t:Tag {key:'recycling:glass_bottles'})<-[:HAS_TAG]-(n:OsmNode)
	set n.glass = t.value
    detach delete t;

match (t:Tag {key:'comment'})<-[:HAS_TAG]-(n:OsmNode)
	set n.position = t.value detach delete t;

match (t:Tag {key:'recycling:clothes'})<-[:HAS_TAG]-(n:OsmNode)
	set n.clothes = t.value detach delete t;

match (t:Tag {key:'amenity', value:'dentist'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Dentist;

match (t:Tag {key:'amenity', value:'dentist'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'fixme'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'FIXME'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'waterway'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Waterway:Weir detach delete t;

match (t:Tag {key:'emergency', value:'defibrillator'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Defibrillator detach delete t;

match (t:Tag {key:'emergency', value:'suction_point'})<-[:HAS_TAG]-(n:OsmNode)
	set n:SuctionPoint detach delete t;

match (t:Tag {key:'indoor'})<-[:HAS_TAG]-(n:OsmNode)
	set n.indoor = t.value detach delete t;

match (t:Tag {key:'water_tank'})<-[:HAS_TAG]-(n:OsmNode)
	set n.waterTank = t.value detach delete t;

match (t:Tag {key:'collection_times'})<-[:HAS_TAG]-(n:OsmNode)
	set n.collectionTimes = t.value detach delete t;

match (t:Tag {key:'amenity', value:'taxi'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Taxi;

match (t:Tag {key:'amenity', value:'taxi'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'bicycle_parking'})<-[:HAS_TAG]-(n:OsmNode)
	set n:BicycleParking;

match (t:Tag {key:'amenity', value:'bicycle_parking'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'capacity'})<-[:HAS_TAG]-(n:OsmNode)
	set n.capacity = t.value detach delete t;

match (t:Tag {key:'fee'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'maxstay'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'parking'})<-[:HAS_TAG]-(n:OsmNode)
	set n.parking = t.value;

match (t:Tag {key:'parking'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'waste_basket'})<-[:HAS_TAG]-(n:OsmNode)
	set n:WasteBasket;

match (t:Tag {key:'amenity', value:'waste_basket'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;
	
match (t:Tag {key:'office', value:'travel_agent'})<-[:HAS_TAG]-(n:OsmNode)
	set n:TravelAgency detach delete t;

match (t:Tag {key:'historic', value:'wayside_cross'})<-[:HAS_TAG]-(n:OsmNode)
	set n:WaysideCross detach delete t;

match (t:Tag {key:'amenity', value:'clock'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Clock detach delete t;

match (t:Tag {key:'display'})<-[:HAS_TAG]-(n:OsmNode)
	set n.display = t.value detach delete t;

match (t:Tag {key:'support'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'visibility'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'highway', value:'steps'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Highway:Steps detach delete t;

match (t:Tag {key:'railway', value:'signal'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Railway:Signal;

match (t:Tag {key:'railway', value:'signal'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway:signal:direction'})<-[:HAS_TAG]-(n:OsmNode)
	set n.direction = t.value;

match (t:Tag {key:'railway:signal:direction'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway:signal:main'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway:signal:main:form'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway:signal:main:function'})<-[:HAS_TAG]-(n:OsmNode)
	set n.function = t.value;

match (t:Tag {key:'railway:signal:main:function'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway:signal:main:height'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway:signal:main:states'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway:signal:main:substitute_signal'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway:signal:minor'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway:signal:minor:form'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway:signal:position'})<-[:HAS_TAG]-(n:OsmNode)
	set n.position = t.value;

match (t:Tag {key:'railway:signal:position'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway:local_operated'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway:switch'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway:switch:electric'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway:turnout_side'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag)<-[:HAS_TAG]-(n:OsmNode)
	where t.key starts with 'railway:signal'
    detach delete t;

match (t:Tag)<-[:HAS_TAG]-(n:OsmNode)
	where t.key = 'count'
    detach delete t;

match (t:Tag {key:'amenity', value:'parking_entrance'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'light_rail'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'railway', value:'buffer_stop'})<-[:HAS_TAG]-(n:OsmNode)
	set n:BufferStop;

match (t:Tag {key:'railway', value:'buffer_stop'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'parking_space'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Parking detach delete t;

match (t:Tag {key:'layer'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'xmas:feature', value:'tree'})<-[:HAS_TAG]-(n:OsmNode)
    set n:XmasTree;

match (t:Tag {key:'xmas:feature', value:'market'})<-[:HAS_TAG]-(n:OsmNode)
    set n:XmasMarket;

match (t:Tag {key:'xmas:feature'})<-[:HAS_TAG]-(n:OsmNode)
   detach delete t;

match (t:Tag {key:'xmas:day_date'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'xmas:name'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t; 

match (t:Tag {key:'xmas:note'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'xmas:opening_hours'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'man_made'})<-[:HAS_TAG]-(n:OsmNode)
    set n:Mast;

match (t:Tag {key:'man_made'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'mast:type'})<-[:HAS_TAG]-(n:OsmNode)
    set n.type = t.value;

match (t:Tag {key:'mast:type'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'railway', value:'tram_stop'})<-[:HAS_TAG]-(n:OsmNode)
    set n:Tram:Stop;

match (t:Tag {key:'railway', value:'tram_stop'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'railway', value:'station'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'railway', value:'milestone'})<-[:HAS_TAG]-(n:OsmNode)
    set n:Railway:Milestone;

match (t:Tag {key:'railway', value:'milestone'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'railway', value:'phone'})<-[:HAS_TAG]-(n:OsmNode)
    set n:Railway:Telephone;

match (t:Tag {key:'railway', value:'phone'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'railway', value:'site'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'information'})<-[:HAS_TAG]-(n:OsmNode)
    set n.information = t.value;
	
match (t:Tag {key:'information'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'tourism'})<-[:HAS_TAG]-(n:OsmNode)
    set n:Tourism:Information;

match (t:Tag {key:'tourism'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'delivery'})<-[:HAS_TAG]-(n:OsmNode)
    set n.delivery = t.value;

match (t:Tag {key:'delivery'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'image'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'railway:ref'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'railway:station_category'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'uic_ref'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'beauty'})<-[:HAS_TAG]-(n:OsmNode)
    set n.beauty = t.value;

match (t:Tag {key:'beauty'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'amenity', value:'doctors'})<-[:HAS_TAG]-(n:OsmNode)
    set n:Doctor detach delete t;

match (t:Tag {key:'healthcare:speciality'})<-[:HAS_TAG]-(n:OsmNode)
    set n.speciality = t.value detach delete t;

match (t:Tag {key:'addr:housename'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'railway:milestone:catenary_mast'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'railway:position'})<-[:HAS_TAG]-(n:OsmNode)
    set n.position = t.value;

match (t:Tag {key:'railway:position'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'amenity', value:'school'})<-[:HAS_TAG]-(n:OsmNode)
    set n:School;

match (t:Tag {key:'amenity', value:'school'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'emergency', value:'key_depot'})<-[:HAS_TAG]-(n:OsmNode)
    set n:KeyDepot detach delete t;

match (t:Tag {key:'emergency_ward_entrance'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'railway:position:exact'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'emergency'})<-[:HAS_TAG]-(n:OsmNode)
    set n:Siren;

match (t:Tag {key:'emergency'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'email'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'office', value:'association'})<-[:HAS_TAG]-(n:OsmNode)
   set n:Association;

match (t:Tag {key:'office', value:'employment_agency'})<-[:HAS_TAG]-(n:OsmNode)
   set n:EmploymentAgency;

match (t:Tag {key:'office'})<-[:HAS_TAG]-(n:OsmNode)
   detach delete t;

match (t:Tag {key:'amenity', value:'public_bookcase'})<-[:HAS_TAG]-(n:OsmNode)
   set n:PublicBookcase detach delete t;

match (t:Tag {key:'public_bookcase:type'})<-[:HAS_TAG]-(n:OsmNode)
   set n.type = t.value detach delete t;

match (t:Tag)<-[:HAS_TAG]-(n:OsmNode)
	where t.key starts with 'addr2'
    detach delete t;

match (t:Tag {key:'fax'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'amenity', value:'marketplace'})<-[:HAS_TAG]-(n:OsmNode)
    set n:MarketPlace;

match (t:Tag {key:'amenity', value:'marketplace'})<-[:HAS_TAG]-(n:OsmNode)
    detach delete t;

match (t:Tag {key:'organic'})<-[:HAS_TAG]-(n:OsmNode)
    set n.organic = t.value detach delete t;

match (t:Tag {key:'craft', value:'tailor'})<-[:HAS_TAG]-(n:OsmNode)
    set n:Tailor detach delete t;

match (t:Tag) where t.key starts with 'disused' detach delete t;

match (t:Tag {key:'office:VRS'}) detach delete t;

match (t:Tag {key:'artist_name'}) detach delete t;

match (t:Tag {key:'artwork_type'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Sculpture;

match (t:Tag {key:'artwork_type'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'amenity', value:'bar'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Bar detach delete t;

match (t:Tag {key:'takeaway'})<-[:HAS_TAG]-(n:OsmNode)
	set n.takeaway = t.value detach delete t;
	
match (t:Tag {key:'railway:ref:parent'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'site'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'craft', value:'shoemaker'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Shoemaker detach delete t;

match (t:Tag {key:'highway', value:'street_lamp'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Highway:StreetLamp;

match (t:Tag {key:'highway', value:'street_lamp'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'colour'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'genus'})<-[:HAS_TAG]-(n:OsmNode)
	set n.genus = t.value detach delete t;

match (t:Tag {key:'height'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'leaf_cycle'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'leaf_type'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag {key:'drive_through'})<-[:HAS_TAG]-(n:OsmNode)
	detach delete t;

match (t:Tag)<-[:HAS_TAG]-(n:OsmNode) where t.key starts with 'payment'
	detach delete t;

match (t:Tag {key:'craft', value:'electrician'})<-[:HAS_TAG]-(n:OsmNode)
	set n:Electrician detach delete t;

match (t:Tag {key:'defibrillator:location'})<-[:HAS_TAG]-(n:OsmNode)
	set n.location = t.value detach delete t;

match (t:Tag) detach delete t;
