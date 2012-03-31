# Nasıl?

1) Önce dal oluşturuldu,

	$ git clone ...
	$ git checkout master
	$ git checkout -b bugfix-login

2) bağımlılıkları kurup, migrasyonu sağlayalım,

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

3) Kullanıcının erişememesini sağlayan

	$ vim app/controllers/application_controller.rb
	before_filter :authenticate_user!

satırı bu diyor ki,

	application seviyesinde authentication yetkiyi kontrol et

ama senin ihtiyacın olan bu değil. O yüzden önce bu satırı silelim.

İstediğimiz sadece belirlediğimiz sayfalarda yetki kontrolü olsun.
Buunlar hangileri pekiyi?

	$ dir app/controllers/
	a_controller.rb
	application_controller.rb
	articles_controller.rb
	forms_controller.rb
	sessions_controller.rb

Bu dosyaların ilk satırlarına yakından bakalım,

	# application_controller.rb
	class ApplicationController < ActionController::Base

	# a_controller.rb
	class AController < ApplicationController

	# articles_controller.rb
	class ArticlesController < ApplicationController

burada bir şey dikkatini çekmiş olmalı ve bu Python sınıflarına benziyor,

	class Çocuk < Ebeveyn

yani miraslanma! Dolayısıyla application_controller'da yapılan bir şey tümünde
etkili, o yüzden senin eklediğin satır tüm application'u etkiliyor. Oradan
kaldırdık, ekleyeceğimiz yer ise bu durumda articles_controller olacak,

	$ vim app/controllers/articles_controller.rb
	before_filter :authenticate_user!

Bu ilk sorunumuzu çözdü. Durumu kayıt altına alalım.

	$ git add .
	$ git commit -a -m "controller: hepsi değil sadece application auth
	gerektirsin"

4) sunucuyu başlatıp

	$ rails s --binding=1.2.3.4

ana sayfaya girmeye çalısınca, http://1.2.3.4:300

	NoMethodError in A#index
	Showing /home/seyyah/work/_mutfak/vys_deneme/app/views/a/index.html.erb where line #30 raised:

	undefined method `model_name' for NilClass:Class
	Extracted source (around line #30):

	27:
	28: <h4> Kullanıcı Girişi </h4>
	29:
	30:  <%= form_for(@article) do |f| %>
	31:   <% if @article.errors.any? %>
	32:     <div id="error_explanation">
	33:       <h2><%= pluralize(@article.errors.count, "error") %>
		prohibited this article from being saved:</h2>


Login formu kullanıcı adı ve parolasının girileceği bir alan olacak bu ise
`articles` tablosundan değil `users` tablosundan çekilecek. Şöyle yapalım index
sayfasından login formunu kaldıralım,

	$ vim app/views/a/index.html.erb
	28-54. satırlar arasını sildim

url'de girilen http://1.2.3.4:3000/login adresinden zaten form sağlanıyor.
Kullanıcıyla alakalı da seed dosyasına girdi yapalım,

@basaral, ortalık çok karışmış tablolar, formlar vs.

En iyisi senin statik sayfaların üzerine login formunu ekleyelim. Bunu ise
ayrıca dokumante edeceğim. https://github.com/seyyah/auth-demo dan sırayla:
auth, cancan, cancan-role.
