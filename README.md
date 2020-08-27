# CookBookmark

今まで作ったことのある料理を「ブックマーク」として保存しておけるサービスです．

## build
```
docker-compose build
```

## db create
```
docker-compose run web rake db:create
docker-compose run web bundle exec ridgepole --config config/database.yml --file config/Schemafile --apply
```

## start server
```
docker-compose up -d
```
