class Phpmyadmin < Formula
  desc "Tool intended to handle the administration of MySQL over the Web"
  homepage "http://www.phpmyadmin.net"
  url "https://github.com/phpmyadmin/phpmyadmin/archive/RELEASE_4_5_0_2.zip"
  sha256 "da5dd76e5cb25c56697b3abe687920d41879b74195e084be96c2a6e02e0b27f7"
  head "https://github.com/phpmyadmin/phpmyadmin.git"

  if build.with? "mcrypt"
    depends_on "php53-mcrypt" if Formula["php53"].linked_keg.exist?
    depends_on "php54-mcrypt" if Formula["php54"].linked_keg.exist?
    depends_on "php55-mcrypt" if Formula["php55"].linked_keg.exist?
    depends_on "php56-mcrypt" if Formula["php56"].linked_keg.exist?
  end

  unless MacOS.prefer_64_bit?
    option "without-mcrypt", "Exclude the php-mcrypt module"
  end

  def install
    (share+"phpmyadmin").install Dir["*"]

    unless File.exist?(etc+"phpmyadmin.config.inc.php")
      cp (share+"phpmyadmin/config.sample.inc.php"), (etc+"phpmyadmin.config.inc.php")
    end
    ln_s (etc+"phpmyadmin.config.inc.php"), (share+"phpmyadmin/config.inc.php")
  end

  test do
    shell_output("phpunit --version").include?(version)
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
        <IfModule mod_authz_core.c>
          Require all granted
        </IfModule>
        <IfModule !mod_authz_core.c>
          Order allow,deny
          Allow from all
        </IfModule>
      </Directory>
    Then, open http://localhost/phpmyadmin

    More documentation : file://#{share}/phpmyadmin/doc/

    Configuration has been copied to #{etc}/phpmyadmin.config.inc.php
    Don't forget to:
      - change your secret blowfish
      - uncomment the configuration lines (pma, pmapass ...)

    EOS
  end
end
