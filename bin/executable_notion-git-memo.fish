#!/usr/bin/env fish

set notion_token $NOTION_API_TOKEN
set database_id "010c7722d414408b8e9da200dbd47268"
set repository_name (basename -s .git (git remote -v | grep fetch | awk '{print $2}'))
set branch_name (git branch --show-current)

# データベースのクエリ
function query_database
    set response (curl -s -X POST "https://api.notion.com/v1/databases/$database_id/query" \
        -H "Authorization: Bearer $notion_token" \
        -H "Notion-Version: 2022-06-28" \
        -H "Content-Type: application/json" \
        --data '{
            "filter": {
                "and": [
                    {
                        "property": "repository",
                        "rich_text": {
                            "equals": "'$repository_name'"
                        }
                    },
                    {
                        "property": "branch",
                        "rich_text": {
                            "equals": "'$branch_name'"
                        }
                    }
                ]
            }
        }')
    # jqを使用してページのURLを取得
    echo $response | jq -r '.results[0].url // ""'
end

# 新しいページの作成
function create_page
    set response (curl -s -X POST "https://api.notion.com/v1/pages" \
        -H "Authorization: Bearer $notion_token" \
        -H "Notion-Version: 2022-06-28" \
        -H "Content-Type: application/json" \
        --data '{
            "parent": { "database_id": "'$database_id'" },
            "properties": {
                "Name": {
                    "title": [
                        {
                            "text": { "content": "'$repository_name' - '$branch_name'" }
                        }
                    ]
                },
                "repository": {
                    "rich_text": [
                        {
                            "text": { "content": "'$repository_name'" }
                        }
                    ]
                },
                "branch": {
                    "rich_text": [
                        {
                            "text": { "content": "'$branch_name'" }
                        }
                    ]
                }
            }
        }')
    # jqを使用して新しいページのURLを取得
    echo $response | jq -r '.url'
end

# データベースのクエリを実行し、URLを取得
set page_url (query_database)

if test -n "$page_url"
    echo "Page URL: $page_url"
		open $page_url
else
    set new_page_url (create_page)
    echo "New Page URL: $new_page_url"
		open $new_page_url
end
