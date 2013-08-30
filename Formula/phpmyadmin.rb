require 'formula'

class Phpmyadmin < Formula
  homepage 'http://www.phpmyadmin.net'
  url 'http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/4.0.5/phpMyAdmin-4.0.5-all-languages.tar.gz/download#!md5!3adfd4bf54a944c9fea9e30cb7f956c3'
  sha1 '82d44152a445e9a614bdfac405e74a80d08f7881'
  version '4.0.5'
  head 'https://github.com/phpmyadmin/phpmyadmin.git'

  if build.include?('without-mcrypt') && MacOS.prefer_64_bit?
    raise "64-bit machines cannot use phpmyadmin without mcrypt"
  end

  unless build.include? 'without-mcrypt'
    depends_on "php53-mcrypt" if Formula.factory("php53").linked_keg.exist?
    depends_on "php54-mcrypt" if Formula.factory("php54").linked_keg.exist?
    depends_on "php55-mcrypt" if Formula.factory("php55").linked_keg.exist?
  end

  unless MacOS.prefer_64_bit?
    option 'without-mcrypt', "Exclude the php-mcrypt module"
  end

  def install
    (share+'phpmyadmin').install Dir['*']
  end

  def caveats; <<-EOS.undent
    Note that this formula will NOT install mysql. It is not
    required since you might want to get connected to a remote
    database server.

    Webserver configuration example (add this at the end of
    your /etc/apache2/httpd.conf for instance) :
      Alias /phpmyadmin #{HOMEBREW_PREFIX}/share/phpmyadmin
      <Directory #{HOMEBREW_PREFIX}/share/phpmyadmin/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        Allow from all
      </Directory>
    Then, open http://localhost/phpmyadmin

    More documentation : file://#{share}/phpmyadmin/doc/

    Don't forget to copy config.sample.inc.php to config.inc.php and :
      - change your secret blowfish
      - uncomment the configuration lines (pma, pmapass ...)

    EOS
  end
end
