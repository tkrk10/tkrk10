Welcome
Here is TokyoRubyKaigi10 Web site Repo. 

http://tkrk10.herokuapp.com/ | git@heroku.com:tkrk10.git

How to make Dev Env
>Install rbenv 
Install ruby-build 
git clone git@bitbucket.org:xxxxx/tkrk10.git 
rbenv local 1.9.3-p193 
rbenv rehash 
make init 
heroku toolbelt のインストール

Sample (To Build DevEnv)
だいたい こんなかんじで動くはず ( わからなかったら聞いて～ ) 
>git clone するまで(Install rbenv and ruby-build ) のコマンド SAMPLE
cd
git clone git://github.com/sstephenson/rbenv.git .
rbenv echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile 
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile 
exec $SHELL 
mkdir -p ~/.rbenv/plugins cd ~/.rbenv/plugins 
git clone git://github.com/sstephenson/ruby-build.git .rbenv/plugins 
exec $SHELL 
rbenv install 1.9.3-p193 
rbenv global 1.9.3-p193 
rbenv rehash
