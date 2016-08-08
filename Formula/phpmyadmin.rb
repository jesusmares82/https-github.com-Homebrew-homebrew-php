require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Phpmyadmin < Formula
  desc "Administration of MySQL over the Web"
  homepage "http://www.phpmyadmin.net"
  url "https://github.com/phpmyadmin/phpmyadmin/archive/RELEASE_4_6_3.tar.gz"
  sha256 "f205884516aa54c8ecce23537d1d2da7ce8d1bce9bad8b2e75ed4485d00690aa"
  head "https://github.com/phpmyadmin/phpmyadmin.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b6d4b1581936610dcad0fce2bff7fe16e40201306bb1d1da83f3909f390bf3db" => :el_capitan
    sha256 "d71de17b44d5bed82f80651288f475253a9343e14480ed79f337978c407f3516" => :yosemite
    sha256 "4f57b03aecf16bfe3b276a084122f896e002e1db9b375fdd7990e0c6568887a4" => :mavericks
  end

  depends_on PhpMetaRequirement
  depends_on "php53-mcrypt" if Formula["php53"].linked_keg.exist?
  depends_on "php54-mcrypt" if Formula["php54"].linked_keg.exist?
  depends_on "php55-mcrypt" if Formula["php55"].linked_keg.exist?
  depends_on "php56-mcrypt" if Formula["php56"].linked_keg.exist?
  depends_on "php70-mcrypt" if Formula["php70"].linked_keg.exist?
  depends_on "php71-mcrypt" if Formula["php71"].linked_keg.exist?

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
    assert File.exist?("#{etc}/phpmyadmin.config.inc.php")
  end
end
