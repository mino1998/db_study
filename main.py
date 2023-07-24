# 필요한 패키지를 import 해보자.
# mongoDB 사용을 위한 package import
from pymongo import MongoClient

# 연결
conn=MongoClient('localhost',port=27017)
# print(conn) # 객체가 print 되었다면 연결 성공!

# DB 연결(사용 설정)
db=conn.mino # mino라는 DB가 없으면 생성될 것이고 있으면 연결됨

# Collection 사용 설정
collect = db.data # data 가 컬렉션 이름이네 실제로

# result=collect.insert_one({"empno":"10001", "name":"민호",
#                     "phone":"010-1111-1111","age":25}) #한글이 깨지는지 확인해보자.
# #print(dir(result)) # object에 dir이라 하면 뭘 가지고 있는지 보여준다.
# # 'acknowledged', 'inserted_id' 이걸 부를 수 있을것 같다.
# #print(result.acknowledged, result.inserted_id) #성공 여부와 삽입된 id
# #이번엔 배열을 집어넣어 보자.
# results=collect.insert_many([{"empno":"10003", "name":"미노",
#                     "phone":"010-2222-2222","age":25},
#                      {"empno":"10002", "name":"mino",
#                     "phone":"010-0000-0000","age":24}])
#print(dir(results)) # 동일하게 'acknowledged', 'inserted_ids' 이 보인다.
#print(results.inserted_ids)

# 삽입, 삭제, 갱신을 한다면 우리에게 정보를 줘야 한다. (회원가입에 성공했다. 등...)
# MongoDB는 느슨한 트랜잭션이라 Commit, Rollback이 없다. 하지만 그렇다고 바로 적용되는 것은 아니다.

# 데이터 조회
# 데이터 조회를 하게 되면 "커서"를 리턴합니다.
# 커서는 한번 만들면 "전진" 만 가능하기에 "재사용이 불가능"합니다.
# 그러기에 다시 만들어주던가 해야합니다. -> 계속 버리기에 메모리 효율이 좋다. (계속 안가지고 있음)

# res=collect.find()
# print(dir(res))
# <pymongo.cursor.Cursor object at 0x000001CAFDF0E500> 커서라고 결과가 나옴
# for temp in res:
#     print(type(temp)) # 커서를 순차적으로 접근하면 dict로 접근이 가능하다.

# for temp in res:
#     print(temp["name"])
#     print(temp.get("name","이름 없음")) #예외처리를 위한 걸까? "name"이 없다면 이름없음을 출력하기

# for temp in res:
#     print(temp.get("name","이름 없음"))

# res2= collect.find({"age":{"$lt":25}}).sort("age")
# for temp in res2:
#     print(temp.get("name","이름 없음"))


# 수정하기
collect.update_many(
    {'empno':"10001"},
    {'$set':{'name':'이민호'}} #수정 시 set 연산자가 들어가야 합니다.
)
res3=collect.find()
for temp in res3:
    print(temp)