use mino;

db;

show dbs;

db.mycollection.insertOne({name:1})
show dbs;
show collections;
db.mycollection.renameCollection("mino");


// collection 생성
db.createCollection('cappedCollection',{capped:true,size:10000})
// 데이터 1개 삽입
db.cappedCollection.insertOne({x:1})
// 데이터 확인
db.cappedCollection.find()
// 많은 양의 데이터 삽입
for(i=0;i<1000;i++){
    db.cappedCollection.insertOne({x:i})
}
// 데이터 확인, 1000개를 넣었는데 어림도 없다.
db.cappedCollection.find()
