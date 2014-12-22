require 'formula'

class Phpmyadmin3 < Formula
  homepage 'http://www.phpmyadmin.net'
  url 'https://github.com/phpmyadmin/phpmyadmin/archive/RELEASE_3_5_8_2.tar.gz'
  sha256 '2c97bd076a923c3742caa28fc343e4d63294b32cf68f7af79fe8b7eb2a8012dc'
  head 'https://github.com/phpmyadmin/phpmyadmin.git'

  if build.with? 'mcrypt'
    depends_on "php53-mcrypt" if Formula['php53'].linked_keg.exist?
    depends_on "php54-mcrypt" if Formula['php54'].linked_keg.exist?
    depends_on "php55-mcrypt" if Formula['php55'].linked_keg.exist?
    depends_on "php56-mcrypt" if Formula['php56'].linked_keg.exist?
  end

  unless MacOS.prefer_64_bit?
    option 'without-mcrypt', "Exclude the php-mcrypt module"
  end

  def install
    (share+'phpmyadmin3').install Dir['*']

    if !(File.exists?(etc+'phpmyadmin3.config.inc.php'))
      cp (share+'phpmyadmin3/config.sample.inc.php'), (etc+'phpmyadmin3.config.inc.php')
    end
    ln_s (etc+'phpmyadmin3.config.inc.php'), (share+'phpmyadmin3/config.inc.php')
  end

  def caveats; <<-EOS.undent
    Note that this formula will NOT install mysql. It is not
    required since you might want to get connected to a remote
    database server.

    Webserver configuration example (add this at the end of
    your /etc/apache2/httpd.conf for instance) :
      Alias /phpmyadmin3 #{HOMEBREW_PREFIX}/share/phpmyadmin3
      <Directory #{HOMEBREW_PREFIX}/share/phpmyadmin3/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        <IfModule mod_authz_core.c>
          Require all granted
        </IfModule>
        <IfModule !mod_authz_core.c>
          Order allow,deny
          Allow from all
        </IfModule>
      </Directory>
    Then, open http://localhost/phpmyadmin3

    More documentation : file://#{share}/phpmyadmin3/doc/

    Configuration has been copied to #{etc}/phpmyadmin3.config.inc.php
    Don't forget to:
      - change your secret blowfish
      - uncomment the configuration lines (pma, pmapass ...)

    EOS
  end
end
