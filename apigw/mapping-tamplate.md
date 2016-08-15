# contact 関数用マッピングテンプレート

```
## convert HTTP POST data to JSON for insertion directly into a Lambda function

## first we we set up our variable that holds the tokenised key value pairs
#set($httpPost = $input.path('$').split("&"))

## next we set up our loop inside the output structure
{
  "stage" : "$context.stage",

#foreach( $kvPair in $httpPost )
 ## now we tokenise each key value pair using "="
 #set($kvTokenised = $kvPair.split("="))
 ## finally we output the JSON for this pair and add a "," if this isn't the last pair
 "$kvTokenised[0]" : "$kvTokenised[1]"#if( $foreach.hasNext ),#end
#end

#if ($httpPost.length() == 0)
 "email": $input.json('email'),
 "message": $input.json('message')
#end

}
```
