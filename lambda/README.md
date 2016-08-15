# ハンズオン環境で作成するLambda関数

```
lambda/
├── README.md
├── functions
│   └── contact            contact関数用ディレクトリ
│       ├── config.yaml    Goで作成したコアライブラリが利用する設定ファイル
│       └── main.go        Lambda関数本体
├── project.json           プロジェクト全体の設定ファイル
└── request_contact.json   contact関数をテストするための引数JSONファイル
```

## 関数を実行するroleの指定

terraformで作成した"handson-app-role"のARNを project.json の role に指定します。

```
{
  "name": "lambda-handson-jawsug-okinawa-201608",
  "description": "lambda-handson-jawsug-okinawa-201608",
  "memory": 128,
  "timeout": 5,
  "role": "arn:aws:iam::あなたのAWSアカウントID:role/handson-app-role",
  "environment": {}
}
```
