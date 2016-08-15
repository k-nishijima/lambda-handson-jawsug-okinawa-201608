# ハンズオン環境の構築

## terraformを実行するIAMユーザー

AmazonDynamoDBFullAccessとAWSLambdaFullAccessの管理ポリシー（Table作成用）のアタッチと、IAM role の作成権限が必要です。

~/.aws/credentials にあるprofile名をproviderで指定してください。この例ではlambda-handson-201608というprofile名です。

IAM関連の最低限必要な権限：

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1471157897000",
            "Effect": "Allow",
            "Action": [
                "iam:CreateRole",
                "iam:CreatePolicy",
                "iam:GetPolicy",
                "iam:AttachRolePolicy",
                "iam:GetRole",
                "iam:ListInstanceProfilesForRole",
                "iam:ListEntitiesForPolicy",
                "iam:ListRolePolicies",
                "iam:UpdateAssumeRolePolicy",
                "iam:DeleteRole",
                "iam:DetachUserPolicy",
                "iam:DetachRolePolicy"
            ],
            "Resource": [
                "arn:aws:iam::*:*"
            ]
        }
    ]
}
```

## アプリ用に作成されるリソース

"handson-app-role" と言う名前でロールが作成されます。このロールもAWSLambdaFullAccessとAmazonDynamoDBFullAccessという強い権限を持ったポリシーをアタッチしています。
実際のアプリケーションでは権限を絞ったロールを作成し、適用してください。

また、DynamoDBのテーブルが1つ作成されます。

## terraformの実行

```
 terraform plan
```

でプランニングを実行してください。問題無さそうなら、

```
 terraform apply
```

で環境を作成します。

作成が完了したら、

```
 terraform show
```

で、作成したリソースの中から「aws_iam_role.handson-app-role」のARNをメモしてください。後のLambda関数のところで必要になります。

ハンズオンが終了したら

```
 terraform destroy
```

ですべてのリソースを削除してください（実行を再確認したあとはundoはありませんのでご注意ください）。
