require 'formula'

def php55_installed?
  `php -v`.match(/5\.5\./)
end

def php54_installed?
  `php -v`.match(/5\.4\./)
end

def php53_installed?
  `php -v`.match(/5\.3\./)
end

class Phpmyadmin < Formula
  homepage 'http://www.phpmyadmin.net'
  url 'http://downloads.sourceforge.net/project/phpmyadmin/phpMyAdmin/4.0.4/phpMyAdmin-4.0.4-all-languages.tar.bz2'
  sha1 '572cf575af7dc05a419c2aad71796d44175a3501'

  if build.include?('without-mcrypt') && MacOS.prefer_64_bit?
    raise "64-bit machines cannot use phpmyadmin without mcrypt"
  end

  unless build.include? 'without-mcrypt'
    depends_on 'php53-mcrypt' if php53_installed?
    depends_on 'php54-mcrypt' if php54_installed?
    depends_on 'php55-mcrypt' if php55_installed?
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

    More documentation : file://#{share}/phpmyadmin/Documentation.html
    
    Don't forget to copy config.sample.inc.php to config.inc.php and :
      - change your secret blowfish
      - uncomment the configuration lines (pma, pmapass ...)
    
    EOS
  end
end
