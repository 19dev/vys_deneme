# Nasıl?

Önce dal oluşturuldu,

	$ git clone ...
	$ git checkout master
	$ git checkout -b bugfix-login

bağımlılıkları kurup, migrasyonu sağlayalım,

	$ bundle
	$ rake db:migrate
	[...]
	==  AddUserOnArticles: migrating ==============================================
	-- add_column(:articles, :user_id, :reference)
	rake aborted!
	An error has occurred, this and all later migrations canceled:

	SQLite3::SQLException: no such table: articles: ALTER TABLE "articles" ADD "user_id" reference

	Tasks: TOP => db:migrate
	(See full trace by running task with --trace)

Böylesi bir hata mesajı aldım. Sıkıntı şu ki `no such table`. Yani tablo yok ki
sütun eklesin. Bu nedenle önce `articles` tablosunu oluşturulmalı, `rake
db:migrate` ise tarihe göre sıralı listenin, 

	20120323235859_create_forms.rb
	20120329233536_create_users.rb
	20120330232112_add_user_on_articles.rb
	20120330232817_add_devise_to_users.rb
	20120330232832_create_articles.rb

sırayla migrasyonu temelinde, birinci yöntem elle migrasyon dosya isimlerinde ki
tarihleri değiştirmek veya migrasyon sırasını kendimiz belirlemek,

	http://guides.rubyonrails.org/migrations.html
	$ rake db:migrate VERSION=20120330232832

gibi. Fakat ben ilk yöntemi kullanacağım dosya sırası şöyle olmalı,

	120120323235859_create_forms.rb
	220120329233536_create_users.rb
	320120330232832_create_articles.rb
	420120330232112_add_user_on_articles.rb
	520120330232817_add_devise_to_users.rb

yani elle başlarına 1,2,3,4,5 ekledim. Böylelikle önce `create` sonra `add`
işlemleri yapılacak. Tabii migrasyon öncesinde `db/development.sqlite3`
dosyasını silelim.

	$ rm -rf db/development.sqlite3
	$ rake db:migrate

Evet her şey yolunda ;)

Bu durumu bir kayıtlayalım,

	$ git add .
	$ git commit -a -m "db:migrate: rename/reorder"


