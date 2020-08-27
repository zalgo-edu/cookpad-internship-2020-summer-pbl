# CookBookmark

今まで作ったことのある料理を「ブックマーク」として保存しておけるサービスです．

## build
```
docker-compose build
```

## db create
```
docker-compose run web rake db:create
docker-compose exec web bundle exec ridgepole -c config/database.yml -E development —apply -f config/Schemafile
```

## start server
```
docker-compose up -d
```
