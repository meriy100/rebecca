# API 使い方


## api/tasks
基本的に200がかえってきたら, 返ってきたjsonをDBに登録してください

500 が返ってきたら, バリデーション以外でエラー(サーバ側でやらかしてるとき)

どのステータスの時にiOS単独で作成するのかは任せますが, 200 で返ってきた時はやめてください

### GET: api/tasks
- パラメータは特になし
- ただユーザのタスクのリストを渡すだけ
- DOING DONE のフィルタはしていないので, ios 側で受け取った後やってください(表示するとき?).
- ログインとの関係でユーザ情報も返しています

### POST: api/tasks
期待されているパラメータ
```json
{
  "task": {
    "user_id": Integer,
    "title": String,
    "weight": Integer,
    "deadline_at": "%Y-%m-%d %H:%M:%S"
  }
}
```
- タスク作成用
- 作成の成功失敗にかかわらず 200 ステータスが返ってきます
- 成功したら` {"user_id": Integer, ....., "updated_at": "%Y-%m-%d %H:%M:%S"} `
- 失敗したら` {"user_id": Integer, ....., "updated_at": "%Y-%m-%d %H:%M:%S", errors: "エラーの理由"} `
  - 失敗するときはバリデーションなので, もう一度入力させてください

### POST: api/tasks/:sync_token/done
期待されているパラメータ
```json
{
  "task": {
    "user_id": Integer,
    "sync_token": "String",
    "title": String,
    "is_done": false,
    "weight": Integer,
    "deadline_at": "%Y-%m-%d %H:%M:%S",
    "created_at": "%Y-%m-%d %H:%M:%S",
    "updated_at": "%Y-%m-%d %H:%M:%S"
  }
}
```
- タスクを終了するため用

- 成功したら` {"user_id": Integer, ....., "updated_at": "%Y-%m-%d %H:%M:%S"} `
- 失敗したら` {"user_id": Integer, ....., "updated_at": "%Y-%m-%d %H:%M:%S", errors: "エラーの理由"} `
  - よっぽどのことがなければ失敗しないと思います(ちゃんと適度にsyncしていれば)
- ios 単独で作成されたタスクが sync せずに飛んできた場合は, こちらで作成したのち終了済にして成功時のjsonを返します
  - `created_at` や `sync_token` はこのとき使うので忘れないようにしてください

### PATCH: api/tasks/:sync_token
期待されているパラメータ
```json
{
  "task": {
    "user_id": Integer,
    "sync_token": "String",
    "title": String,
    "is_done": false,
    "weight": Integer,
    "deadline_at": "%Y-%m-%d %H:%M:%S",
    "created_at": "%Y-%m-%d %H:%M:%S",
    "updated_at": "%Y-%m-%d %H:%M:%S"
  }
}
```
- タスクを更新するため用
- 成功したら` {"user_id": Integer, ....., "updated_at": "%Y-%m-%d %H:%M:%S"} `
- 失敗したら` {"user_id": Integer, ....., "updated_at": "%Y-%m-%d %H:%M:%S", errors: "エラーの理由"} `
  - 失敗するときはバリデーションなので, もう一度入力させてください
- ios 単独で作成されたタスクが sync せずに飛んできた場合は, こちらで作成したのち json を返します
  - `created_at` や `sync_token` はこのとき使うので忘れないようにしてください


### POST: api/tasks/sync
期待されているパラメータ
```json
{
  "tasks": [
    {
      "user_id": Integer,
      "sync_token": "String",
      "title": String,
      "is_done": false,
      "weight": Integer,
      "deadline_at": "%Y-%m-%d %H:%M:%S",
      "created_at": "%Y-%m-%d %H:%M:%S",
      "updated_at": "%Y-%m-%d %H:%M:%S"
    },
    ...
  ],
  "task_updated_at": "%Y-%m-%d %H:%M:%S",
  "sync_at": "%Y-%m-%d %H:%M:%S",
}
```

- タスク同期用
- ios の`task_updated_at > synced_at` の場合ios単独で作成, 更新されたタスクがあると判断しfull_sync を行います
  - `"message": "full_sync"`
- rails の `task_updated_at` のほうが新しいならすべてのタスクの情報を返します
  - `"message": "sync"`
- それ以外ならユーザ情報とメッセージのみを返します
  - `"message": "no_sync"`
```json
{
  "tasks": [
    {
      "user_id": Integer,
      "sync_token": "String",
      "title": String,
      "is_done": false,
      "weight": Integer,
      "deadline_at": "%Y-%m-%d %H:%M:%S",
      "created_at": "%Y-%m-%d %H:%M:%S",
      "updated_at": "%Y-%m-%d %H:%M:%S"
    },
    ...
  ],
  "user": {
    "id": Integer,
    "name": String,
    "email": String
  },
  "message": String
}
```

