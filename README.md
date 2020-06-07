# yomyom 

書籍を登録し、読書時間を記録、レビューができるアプリです  
http://yomyom2.work/  
   
    
![yomyom_top](https://user-images.githubusercontent.com/41112416/83981213-d8ee5100-a956-11ea-8e7f-c3dbe8c9e8b1.png)
![record](https://user-images.githubusercontent.com/41112416/83981241-1e128300-a957-11ea-9779-a9a538cd6da9.png)
![bookshelf](https://user-images.githubusercontent.com/41112416/83981245-28348180-a957-11ea-9fb4-44a5f6a8d6c3.png)
## 機能と使用技術

- インフラ(AWS)  
  EC2  
  RDS  
  S3  
  VPC  
  Route53
  <!-- 使用技術に追記があればこちらに記入 -->
- 単体・統合テスト(RSpec, factory_bot, capybara)
- データベース(MYSQL)
- 画像アップロード(Amason S3, carrierwave, mini_magick, fog)
- ページネーション(kaminari)
- 書籍情報取得(楽天API)
- 検索(ransack)
- デザイン(Bootstrap) 
- グラフ(Chart.js)
- 認証関連(ログイン, 管理者ユーザー)
- ユーザー関連（フォロー・フォロワー）
- 投稿関連（コメント機能）
- 書籍関連（ランキング表示）
- 本棚関連(ステータス、カテゴリー管理)

## 環境

- 言語(Ruby 2.5.3)
- フレームワーク(Rails 5.2.2)
- Docker(開発環境) 
- 開発(VSCode)

