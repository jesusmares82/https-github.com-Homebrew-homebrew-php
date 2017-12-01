require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Phpmyadmin < Formula
  desc "A web interface for MySQL and MariaDB"
  homepage "https://www.phpmyadmin.net"
  url "https://files.phpmyadmin.net/phpMyAdmin/4.7.6/phpMyAdmin-4.7.6-all-languages.tar.gz"
  sha256 "e460e41c2f74bf7093e3f6d3b762eb97df6e1b346234b4b63bb27fc0d9dcd62c"
  head "https://github.com/phpmyadmin/phpmyadmin.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9b9fe3ac56ec1cdc631609535c50772b3f81162cb188098192a560e6938c796c" => :high_sierra
    sha256 "9b9fe3ac56ec1cdc631609535c50772b3f81162cb188098192a560e6938c796c" => :sierra
    sha256 "9b9fe3ac56ec1cdc631609535c50772b3f81162cb188098192a560e6938c796c" => :el_capitan
  end

  depends_on PhpMetaRequirement

  def install
    (share+"phpmyadmin").install Dir["*"]

    unless File.exist?(etc+"phpmyadmin.config.inc.php")
      cp (share+"phpmyadmin/config.sample.inc.php"), (etc+"phpmyadmin.config.inc.php")
    end
    ln_s (etc+"phpmyadmin.config.inc.php"), (share+"phpmyadmin/config.inc.php")
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

    More documentation : file://#{pkgshare}/doc/

    Configuration has been copied to #{etc}/phpmyadmin.config.inc.php
    Don't forget to:
      - change your secret blowfish
      - uncomment the configuration lines (pma, pmapass ...)

    EOS
  end

  test do
    assert_predicate etc/"phpmyadmin.config.inc.php", :exist?
  end
end
