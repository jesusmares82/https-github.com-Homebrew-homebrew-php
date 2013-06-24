require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", Pathname.new(__FILE__).realpath)

class Phppgadmin < Formula
  homepage 'http://phppgadmin.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/phppgadmin/phpPgAdmin%20%5Bstable%5D/phpPgAdmin-5.1/phpPgAdmin-5.1.tar.gz'
  sha1 'ef90fc9942c67ab95f063cacc43911a40d34fbc1'

  depends_on PhpMetaRequirement

  def install
    (share+'phppgadmin').install Dir['*']
  end

  def caveats; <<-EOS.undent
    Note that this formula will NOT install PostgreSQL. It is not
    required since you might want to get connected to a remote
    database server.

    Edit #{HOMEBREW_PREFIX}/share/phppgadmin/conf/config.inc.php to add needed PostgreSQL servers.

    Webserver configuration example (add this at the end of
    your /etc/apache2/httpd.conf for instance) :
      Alias /phppgadmin #{HOMEBREW_PREFIX}/share/phppgadmin
      <Directory #{HOMEBREW_PREFIX}/share/phppgadmin/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        Allow from all
      </Directory>
    Then, restart your web server and open http://localhost/phppgadmin

    More documentation : http://phppgadmin.sourceforge.net/doku.php?id=faq_docs
    EOS
  end
end
